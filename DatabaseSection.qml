
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

    height: parent.height

    // independent query
    DatabaseQuery {
        id: independQuery
        tag: "q2"

        // Donot foget to set the database on independent DatabaseQueries
        database: mainDatabase

        onDatabaseChanged: {
            console.log("independent Query is attached to " + database)
            log.log("independent Query is attached to " + database)
        }

        onValueChanged: {
            console.log("my value is in " + value)
        }
        priority: QmlioDatabase.Highest
        onCompleted: {
            console.log(" independQuery Complete  ------------" + JSON.stringify(
                            value) + "   " + value)

            log.log(value)
        }
    }
    Flickable {
        anchors.fill: parent
        contentHeight: col.height

        Column {
            id: col
            anchors.centerIn: parent

            z: 5
            spacing: 16
            // set value for both Database queries
            Button {

                text: "setValue"
                onClicked: {

                    // fake numeric names
                    var t = Math.random() * 100

                    var fakeValue1 = {
                        name: Math.floor(t),
                        isApla: false,
                        isSted: true
                    }

                    var fakeValue2 = {
                        name: Math.floor(t),
                        isApla: true
                    }

                    // using DatabaseQuery::setValueAsMap for json values,
                    // in case of non json values, use DatabaseQuery::setValue
                    childQuery.child("Trial").child(key1).setValueAsMap(
                                fakeValue1)
                    independQuery.child("Trial").child(key2).setValueAsMap(
                                fakeValue2)
                }
            }

            // get value for both Database queries
            Button {

                text: "getValue"
                onClicked: {

                    childQuery.child("Trial").child(key2).getValue()
                    independQuery.child("Trial").child(key1).getValue()
                }
            }

            // orderByName filter
            Button {

                text: "orderByName"
                onClicked: {
                    // pass true to DatabaseQuery::getValue if getting value with a query
                    independQuery.child("Trial").orderByChild(
                                "name").limitToLast(2).getValue(true)

                    childQuery.child("Trial").orderByKey().limitToLast(
                                2).getValue(true)
                }
            }
            Button {

                text: "set value at deep node"
                onClicked: {

                    childQuery.child("Trial").child(key2).child(
                                "name").setValue("Qmlio Johns")
                }
            }
        }
    }
}
