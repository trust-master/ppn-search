<?php include('assets/includes/header.php'); ?>
            <div id="content">
                <h2>My Profile</h2>
                <div class="col-a col">
                    <div class="sidebar-nav">
                        <ul>
                            <li class="active"><a href="">Basic Info</a></li>
                            <li><a href="">Privacy Settings</a></li>
                            <li><a href="">Notifications &amp; Alerts</a></li>
                        </ul>
                    </div><!-- closes sidebar nav -->
                </div><!-- closes col a -->
                <div class="col-b col">
                    <form action="" class="account-edit">
                        <fieldset class="data-values">
                            <ul>
                                <li>
                                    <label>Displayed Name</label>
                                    <span>Mary W Phelps</span>
                                </li>
                            </ul>
                        </fieldset>
                        <fieldset class="edit-mode">
                            <ul>
                                <li>
                                    <label>First Name</label>
                                    <input type="text" />
                                </li>
                                <li>
                                    <label>Middle Name</label>
                                    <input type="text" />
                                </li>
                                <li>
                                    <label>Last Name</label>
                                    <input type="text" />
                                </li>
                            </ul>
                        </fieldset>
                        <fieldset class="data-values">
                            <ul>
                                <li >
                                    <label>Email</label>
                                    <span>marywphelps@gmail.com</span>
                                </li>
                            </ul>                           
                        </fieldset>
                        <fieldset class="edit-mode">
                            <ul>
                                <li>
                                    <label>New Email</label>
                                    <input type="text" />
                                </li>
                            </ul>
                        </fieldset>
                        <fieldset class="data-values">
                            <ul>
                                <li>
                                    <label>Password</label>
                                    <span>*******</span>
                                </li>
                            </ul>
                        </fieldset>
                        <fieldset class="edit-mode">
                            <ul>
                                <li>
                                    <label>Old Password</label>
                                    <input type="password" />
                                    <p class="required">required</p>
                                </li>
                                <li>
                                    <label>New Password</label>
                                    <input type="password" />
                                    <p class="required">required</p>
                                </li>
                                <li>
                                    <label>Confirm password</label>
                                    <input type="password" />
                                    <p class="required">required</p>
                                </li>
                            </ul>
                        </fieldset>
                        <fieldset>
                            <ul>
                                <li class="data-values">
                                    <label>Privacy</label>
                                    <span>marywphelps@gmail.com</span>
                                     <a href="" class="edit-link">[Manage]</a>
                                </li>
                            </ul>                           
                        </fieldset>
                        <fieldset class="deactivate-account">
                            <label>Deactivate Account</label><a href="" class="edit-link deactivate">Deactivate</a>
                        </fieldset>

                        <fieldset class="last">
                            <a href="" class="cancel">Cancel</a>
                             <input type="submit" value="Save" class="save" />
                         </fieldset>
                    </form>
                </div><!-- closes col b -->
                <div id="deactivate-account">
                    <p>Are you sure you want to deactivate your account?</p>
                    <form action="">
                        <fieldset class="last">
                            <a href="" class="cancel">Cancel</a>
                             <input type="submit" value="Yes" class="save" />
                         </fieldset>
                    </form>

                </div>
<?php include('assets/includes/footer.php'); ?>
