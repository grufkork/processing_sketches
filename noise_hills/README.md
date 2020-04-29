# noise_hills
![Example Frame](https://i.redd.it/8we62qkadmv41.png)
One of my first "proper" processing sketches. 
The code includes some stuff for stepping through the noise in Z and saving it to .png:s, you should probably just have to uncomment it for it to work. Use Processing's movie maker to combine it to a .mov.
The `factor` variable determines the chunk size, it should be a factor of both the width and height. I haven't tried using anything else, but I'm pretty sure it breaks it...


**A short explanation of how this works, copied from my Reddit post:** (excuse my terrible handwriting)

First I fill a 2D array with noise, so I can just lookup the values there instead of doing expensive noise calculations. Then I use what I guess is effectively a fragment shader to calculate the colour of each pixel. I don’t think it’s a particularly efficient way of doing it, but I wanted to try this method and well, it works ¯\\\_(ツ)_/¯

![Projection](https://i.imgur.com/NamvvA4.jpg)  (The “camera” here is the screen) I start by creating a ray on the XZ plane (assuming Z is height). Then, every iteration I move it one step forward, one step down (y+1, z-1) until the Z value is lower than the noise value for that XY coordinate:
![Raycast](https://i.imgur.com/btD3PgQ.jpg)
 Then I move forward only (Y+) until the Z value is greater than the noise value. The number of steps is the thickness at that particular point (the discount “subsurface” lighting):
![Thickness](https://i.imgur.com/gPDKtv4.jpg)
The colour is then determined by the Y coordinate for red, height for green and thickness for blue.

There are a few more magic numbers and transformations to make it look better, but that is the basic idea. 
