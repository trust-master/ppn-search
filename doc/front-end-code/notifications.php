<?php include('assets/includes/header.php'); ?>
            <div id="content">
                <h2>My Profile</h2>
                <div class="col-a col">
                    <div class="sidebar-nav">
                        <ul>
                            <li><a href="">Basic Info</a></li>
                            <li><a href="">Privacy Settings</a></li>
                            <li  class="active"><a href="">Notifications &amp; Alerts</a></li>
                        </ul>
                    </div><!-- closes sidebar nav -->
                </div><!-- closes col a -->
                <div class="col-b col">

                    <form action="">
                        <fieldset>
                            <ul>
                                <li>
                                    <label>Notification Emails</label>
                                    <input type="checkbox" />
                                    <label class="notify">receive follow up notifications via email</label>
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
