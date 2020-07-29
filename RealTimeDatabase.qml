
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
import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QmlioFirebase 1.0

Page {

    title: qsTr("Database")

    // generate random database keys
    property string key1: mainDatabase.key()
    property string key2: mainDatabase.key()

    property string mainDb: "Posts"
    Text {
        id: name
        text: qsTr("text")
    }
    Row {
        width: parent.width
        spacing: 0
        height: parent.height
        DatabaseSection {
        }
        LogSection {
            id: log
        }
    }

    // Main database
    QmlioDatabase {
        id: mainDatabase

        // Donot set QmlioDatabase::persist directly, instead use this signal
        onBeforeInitialised: {
            console.log("is before initialised ")
            persist = true
        }

        // called an error occurs
        onErrorChanged: {
            log.log(errorMsg + "  " + errorCode)
        }

        // emited when the firebase::database instance is intialised
        // Any Database listners attached to this database will not work until this signal is emited
        onDatabaseInitialized: {

            childQuery.addChildListner()
        }

        // attach queries
        queries: [
            DatabaseQuery {
                id: childQuery

                // for quality debuging, set the tag
                tag: "Database.childQuery"

                priority: QmlioDatabase.Normal

                onChildAdded: {
                    console.log("\n------------------q1 Child Added -------------")
                    console.log(JSON.stringify(value) + "  " + value)
                    console.log("\n------------------q1 Child Added END -------------")
                }

                // emited when an query is complete
                onCompleted: {
                    console.log("Complete q1------------" + JSON.stringify(
                                    value) + "   " + value)
                    log("q1 is complete")
                }
            }
        ]
    }
}
