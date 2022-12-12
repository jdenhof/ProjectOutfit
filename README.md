# ProjectOutfit
[![Watch the video](https://i.imgur.com/vKb2F1B.png)](https://youtu.be/03TZkJLSKKc)
## 1 Abstract
With so many things going on in life, remembering what you wore to every event everyday is combursome and for some unachievable. From fashanista to your average hoodie wearer, nobody wants to be seen in the same outfit repeatidly. Everybody picks up their phone every morning, and some even post there outfits of the day to there favorite social media. Save the headache and keep track of your outfits using OOTD.
## 2 Intro
Outfit of the Day -"OOTD" strives to reconcile this adveristy by providing a platform in which users can easily store and track outfits worn. Simply open the app, take a picture, and select which clothes combine to make the outfit. Tag the outfit with an event or simply upload to store your outfit. Outfits can be previed within the Wardrobe Calendar by simply selecting the date or searching a tag. OOTD provides a simple and intuitive platform to take one more stress off your plate.

## 3 Architecture
The Outfit of the Day Application will be an IOS and Android app made on Flutter using Google Cloud Functions to route traffic to Firebase to store the user's saved outfits and clothing.

![Project Outfit Architecture Diagram](https://user-images.githubusercontent.com/113374113/193295951-4de34ec4-aa7b-4718-acef-6d26425b8907.png)
<div align="center">
    <text>Figure 3</text>
</div>

### 3.1 Usecase Diagram
The figure below demonstrates how a user will interact with the app. They first will have to login/register that will use authentication. The user can store an outfit which conists of taking a picture and categorizing outfit. The user can also add individual clothing items. The user can lastly view past outfits.
>>>>
<div align="center">
    <div>
        <img src="https://github.com/jdenhof/ProjectOutfit/blob/main/resources/UsecaseDiagram.png"  width="400" height="400">
    </div>
    <div>
        <text>Figure 3.1</text>
    </div>
</div>

### 3.2 Class Diagram
The figure below classifys our app with a user that has a 0 to infinte wardrobes. A wardrobe consists of all the clothing items that belong to the wardrobe as well as the outfits those clothing items make up. The user will use the calendar class to filter outfits worn based on filter input.
>>>>
<div align="center">
    <div>
        <img src="https://github.com/jdenhof/ProjectOutfit/blob/main/resources/ClassDiagram.png"  width="600" height="400">
    </div>
    <div>
        <text>Figure 3.2</text>
    </div>
</div>

### 3.3 Sequence Diagram
The figure below shows the interactions between the user and various classes within our application.  
<div align="center">
    <div>
        <img src="https://github.com/jdenhof/ProjectOutfit/blob/main/resources/SequenceDiagram.png"  width="600" height="400">
    </div>
    <div> 
        <text>Figure 3.3</text>
    </div>
</div>

## 4 UI 
<table border="0">
 <tr>
    <td><b style="font-size:30px">Home</b></td>
    <td><b style="font-size:30px">Outfit Selector</b></td>
 </tr>
 <tr>
    <td><b style="font-size:20px">Upon opening the app you have easy access to add a new outfit of the day or see previous outfits using the calendar tab.</b></td>
    <td><b style="font-size:20px">After taking a picture of your outfit, the validate the clothing items auto-selected based on your photo.</b></td>
 </tr>
 <tr>
    <td>
    <img src="https://github.com/jdenhof/ProjectOutfit/blob/main/resources/HomeScreen.png"  width="375" height="500">
    </td>
    <td>
    <img src="https://github.com/jdenhof/ProjectOutfit/blob/main/resources/Selection.png"  width="375" height="500">
    </td>
 </tr>
 <tr>
    <td><b style="font-size:30px">Calendar of Outfits</b></td>
    <td><b style="font-size:30px">Settings</b></td>
</tr>
<tr>
    <td><b style="font-size:20px">The calendar tab allows for convienty filter based outfit searches based on clothing item tag, date worn, or name.</b></td>
    <td><b style="font-size:20px"></b>Conviently modify your name and password in the settings menu.</td>
</tr>
<tr>
    <td>
    <img src="https://github.com/jdenhof/ProjectOutfit/blob/main/resources/Calendar.png"  width="375" height="500">
    </td>
    <td>
    <img src="https://github.com/jdenhof/ProjectOutfit/blob/main/resources/Settings.png"  width="375" height="500">
    </td>
 </tr>
</table>

## 5 Risk Analysis & Retrospective
One of the biggest risks we faced with this project was not completing it on time.  We were very ambitious and wanted to pull out all of the stops for this app, including an AI to identify articles of clothing to store in a virtual closet.  Unfortuantely we had to drop this feature for the time being to make sure we completed the essential parts of the project first.  The other problem we ran into was integrating the different API's we needed.  We ran into issues with integrating our authentication serivce in Firebase that delayed our project.  The way around this was utilizing our outside resources to find the solution.  While we did get it to work, it was not ideal to have that delay.  
While we did in the end finish the project.  We were not able to finish all of our planned features.  Right now, it allows the user to take a picture to add an outift that is stored for the user to look back through.  In order to store the outfits the user must register on the app to create an account so that they can access the database that store their images.  If we could go back knowing what we know now of the challenges integrating API's can cuase, we think we would be able to have managed our time better so we could have implemented rudimentary ML so that users coudl select individual articles of clothing to make a virtual closet.  This then could have been used as the starting point of building the AI for automatically identifying clothing items should we continue working on this project in the future.



