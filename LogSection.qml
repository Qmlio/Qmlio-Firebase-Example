
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

Rectangle {
    width: parent.width / 2
    color: "#f2f2f2"
    height: parent.height

    Flickable {
        anchors.fill: parent
        contentHeight: text_.height
        Text {
            id: text_
            font.pixelSize: 15
            wrapMode: Text.WordWrap
            width: parent.width
        }
    }
    Button {
        anchors.bottom: parent.bottom
        text: "Clear"
        onClicked: {
            text_.text = ""
        }
    }

    function log(d) {
        text_.text += d + " \n"
    }
}
