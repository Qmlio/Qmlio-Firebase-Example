
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
import QtQuick 2.9
import QtQuick.Controls 2.2

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Scroll")
    TabBar {
        id: tabBar
        width: parent.width
        currentIndex: swipeView.currentIndex
        z: 5
        Repeater {
            model: ListModel {
                Component.onCompleted: {
                    append({
                               text: "Auth"
                           })
                    append({
                               text: "Realtime Database"
                           })
                    append({
                               text: "Storage"
                           })
                    append({
                               text: "Messaging"
                           })
                }
            }
            delegate: TabButton {
                text: model.text
            }
        }
    }
    SwipeView {
        id: swipeView
        y: tabBar.height
        width: parent.width
        height: parent.height - y
        currentIndex: tabBar.currentIndex

        AuthPage {
        }
        RealTimeDatabase {
        }
        StoragePage {
        }
    }
}
