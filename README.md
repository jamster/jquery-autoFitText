# Documentation

Auto Fit Text is a plugin that allows you to programmatically change the font size of text living in an element. Often times when you have a common layout and dynamic content, you may find headers and certain text boxes overflow, or wrap making the design break. With Auto Fit Text, you can have it reduce the font so that it fits perfectly within the original size set for your container element.

### Dependencies
                
* jQuery 1.6
  
  
### How To Use By Example

Click here for a live demo

First, you want to create your elements in HTML.  In this example, we are showing the characters from the princess bride.  In the design, you don't want the character's name to span past 300px.  If it does, we want it to shrink down to fit within the width of the `h3.name` element.

#### HTML

```html
    <div class="character">
        <h3 class="name">
            <span style="font-size: 42px;">Inigo Montoya</span>
        </h3>
        <div class="info">
            <div class="actor">
                <strong>Played By:</strong> Mandy Patinkin
            </div><img class="image" src="http://ia.media-imdb.com/images/M/MV5BMTI3NDMzNjY1M15BMl5BanBnXkFtZTcwMzc1NTEwMw@@._V1._SX32_CR0,0,32,44_.jpg">
        </div>
        <div class="clearfix"></div>
        <p>
            A spaniard that is an expert in fencing, he has a bit of a drinking problem and spends his entire life looking for the six-fingered man (who killed his father). Inigo and his only friend Fezzik later join Westley in storming the castle. It is in this climactic scene that Inigo finally gets his revenge when he meets Count Rugen.
        </p>
    </div>
    <div class="character">
        <h3 class="name">
            <span style="font-size: 29px;">Prince Humperdinck</span>
        </h3>
        <div class="info">
            <div class="actor">
                <strong>Played By:</strong> Chris Sarandon
            </div><img class="image" src="http://ia.media-imdb.com/images/M/MV5BMTk5ODQ2ODgyNV5BMl5BanBnXkFtZTcwNzYzOTAzMQ@@._V1._SY44_CR1,0,32,44_.jpg">
        </div>
        <div class="clearfix"></div>
        <p>
            Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
        </p>
    </div>
```

#### JavaScript

```javascript
    $(window).load(function(){
        $("div.character h3.name").autoSizeText({maxFontSize: 60})
    });
```

Note the `$(window).load()` usage here instead of the more common `$()` DOM load.  You'll want to utilize this if you are pulling in outside fonts, so that they get loaded and parsed before the font adjustments begin.  Otherwise, you'll notice that they either over or undershoot depending on the font's character widths.


#### CSS

```css
    h3.name {
        width: 300px;
        font-size: 60px;
        white-space:nowrap;
    }
    div.info {
        float: left;
        margin-left: 15px;
    }
```


