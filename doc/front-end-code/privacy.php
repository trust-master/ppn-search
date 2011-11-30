<?php include('assets/includes/header.php'); ?>
            <div id="content">
                <h2>My Profile</h2>
                <div class="col-a col">
                    <div class="sidebar-nav">
                        <ul>
                            <li><a href="">Basic Info</a></li>
                            <li class="active"><a href="">Privacy Settings</a></li>
                            <li ><a href="">Notifications &amp; Alerts</a></li>
                        </ul>
                    </div><!-- closes sidebar nav -->
                </div><!-- closes col a -->
                
                <div class="col-b col">

                    <form action="">
                        <fieldset>
                            <p>To help other IMobile Wellness community members find you, some basic information is open to everyone.  We also suggest setting basics like, Condition Type and Condition History to public so that those looking for support and connections can...</p>
                        </fieldset>
                        <fieldset>
                            <h3>Other Profile Information</h3>
                            <ul>
                                <li class="radio-options radio-options-alt radio-public">

                                    <label class="btn-label">About Me</label>
                                    <div class="radio radio2">               
                                       <input type="radio" id="radio-about1" name="about" checked="checked" />
                                       <label for="radio-about1">Public</label>
                                       <input type="radio" id="radio-about2" name="about"  />
                                       <label for="radio-about2">Private</label>            
                                    </div>
                                
                                </li> 
                                <li class="radio-options radio-options-alt radio-public">

                                    <label class="btn-label">Profile Picture</label>
                                    <div class="radio radio2">               
                                       <input type="radio" id="radio-profile-pic1" name="profile-pic" />
                                       <label for="radio-profile-pic1">Public</label>
                                       <input type="radio" id="radio-profile-pic2" name="profile-pic" checked="checked" />
                                       <label for="radio-profile-pic2">Private</label>            
                                    </div>
                                
                                </li>  
                            </ul>                       
                        </fieldset>
                        <fieldset>
                            <h3>Contact Information</h3>
                            <ul>
                                <li class="radio-options radio-options-alt radio-public">

                                    <label class="btn-label">Email</label>
                                    <div class="radio radio2">               
                                       <input type="radio" id="radio-email1" name="email" checked="checked" />
                                       <label for="radio-email1">Public</label>
                                       <input type="radio" id="radio-email2" name="email"  />
                                       <label for="radio-email2">Private</label>            
                                    </div>
                                
                                </li> 
                                <li class="radio-options radio-options-alt radio-public">

                                    <label class="btn-label">Location</label>
                                    <div class="radio radio2">               
                                       <input type="radio" id="radio-location1" name="location" />
                                       <label for="radio-location1">Public</label>
                                       <input type="radio" id="radio-location2" name="location" checked="checked" />
                                       <label for="radio-location2">Private</label>            
                                    </div>
                                
                                </li>  
                            </ul>                       
                        </fieldset>

                        <fieldset class="last">
                            <a href="" class="cancel">Cancel</a>
                             <input type="submit" value="Save" class="save" />
                         </fieldset>
                    </form>
                </div><!-- closes col b -->
<?php include('assets/includes/footer.php'); ?>
