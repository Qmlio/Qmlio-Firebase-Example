
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
import QtQuick 2.11
import QtQuick.Controls 2.2
import QmlioFirebase 1.0


// Mandatory
Page {
    property var fakeCredentials: ({

                                   })
    //image to display user's google account avatar
    Image {
        z: 2
        id: img
        width: 100
        height: width
    }

    // Firebase auth
    QmlioAuth {
        id: auth

        // Called when a task is finished
        onTaskFinished: {
            console.log(success + " " + actionId + " " + JSON.stringify(user))

            // get photo url if signed in with Google Credentials
            img.source = photoUrl()
        }
        // called an error occurs
        onErrorChanged: {
            console.log(errId + "  " + errMsg)
        }
    }
    Flickable {
        anchors.fill: parent
        contentHeight: e.height

        Column {
            id: e
            property string currentuser
            anchors.centerIn: parent
            spacing: 16

            Repeater {
                model: ListModel {
                    Component.onCompleted: {
                        append({
                                   text: "Anonymously"
                               })
                        append({
                                   text: "sign in with Email"
                               })
                        append({
                                   text: "Google account"
                               })
                        append({
                                   text: "Register"
                               })
                        append({
                                   text: "Update email"
                               })
                        append({
                                   text: "Update Password"
                               })
                        append({
                                   text: "Reset Password"
                               })
                        append({
                                   text: "Sign out"
                               })
                        append({
                                   text: "Delete Account"
                               })
                    }
                }
                delegate: Button {
                    text: model.text
                    onClicked: {

                        performTask(index)
                    }
                }
            }
        }
    }
    function performTask(index) {
        console.log("my idnexis " + index)
        switch (index) {
        case 0:
            // signin Anonymously
            auth.signInWithCredential(QmlioAuth.Anonymously)
            break
        case 1:
            // sign in with email and password
            auth.signIn(fakeCredentials.email, fakeCredentials.password)
            break
        case 2:
            // sign in with gmail account
            auth.signInWithCredential(QmlioAuth.GoogleSignIn)
            break
        case 3:
            // generate a random credentials
            var fakeEmail = fEmail()

            var fakepassword = "qtiswell"

            auth.registerUser(fakeEmail, fakepassword)

            // save current user details temproralily
            fakeCredentials.email = fakeEmail
            fakeCredentials.password = fakepassword
            break
        case 4:
            var ffEMail = fEmail()
            fakeCredentials.email = ffEMail

            // update useremail
            auth.updateEmail(ffEMail)

            break
        case 5:
            var ffakePassword = "qtworldsummit"
            fakeCredentials.password = ffakePassword

            // update password
            auth.updatePassword(ffakePassword)
            break
        case 6:
            // reset user password
            auth.sendPasswordResetEmail(fakeCredentials.email)
            break
        case 7:
            // signout user
            auth.signOut()
            break
        case 8:
            // delete current user
            auth.deleteUser()
            break
        }
    }
    function fEmail() {
        return "qmlio" + Math.floor(Math.random() * 200) + "@gmail.com"
    }
}
