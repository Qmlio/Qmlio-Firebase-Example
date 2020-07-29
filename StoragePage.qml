
/* Copyright (c) 2020 Qmlio
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
import QtQuick 2.0
import QtQuick.Controls 2.2
import QmlioFirebase 1.0

Page {

    title: qsTr("Storage")
    property string filePath: "" // set file path
    property string filename: "" // set file name

    Row {
        width: parent.width
        spacing: 0
        height: parent.height
        StorageSection {
        }
        LogSection {
            id: log
        }
    }

    QmlioStorage {
        id: storage
        // emited when the firebase::storage instance is intialised
        onInitialised: {
            log.log("storage is initialised")
        }

        // called an error occurs
        onErrorChanged: {
            log.log(errorMsg + "  " + errorCode)
        }

        // attach queries
        queries: [
            StorageQuery {
                id: childQuery
                // for quality debuging, set the tag
                tag: "Storate.childQuery"

                // emited when upload is compeleted
                onUploadComplete: {
                    // try getting the link
                    child("wasswa").getLink(filename)
                }

                onPaused: {
                    log.log("Transfer paused")
                }

                onResumed: {
                    log.log("Transfer resumed")
                }

                onCancelled: {
                    log.log("Transfer canceled")
                }
                onLinkGenerated: {
                    log.log("link is  " + link)
                }

                onTransferedSizeChanged: {
                    log.log("transfered " + size)
                }
                onTotalSizeChanged: {
                    log.log("My tottal is  " + size)
                }
            }
        ]
    }
}
