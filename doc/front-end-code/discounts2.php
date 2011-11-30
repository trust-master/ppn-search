<?php include('assets/includes/header.php'); ?>
            <div id="content">
                <h2>Company: Rotor Rooter Inc.</h2>
                
                <div class="col-a col">
                    <div class="sidebar-nav">
                        <ul>
                            <li class="active"><a href="">Basic Info</a></li>
                            <li><a href="">Service Info</a></li>
                            <li><a href="">Credentials</a></li>
                            <li><a href="">Alerts</a></li>
                            <li><a href="">Discounts</a></li>
                        </ul>
                    </div><!-- closes sidebar nav -->
                </div><!-- closes col a -->
                <div class="col-b col">
                    <form action="">
                        <fieldset>
                            <div class="design-discount">
                                <h3>Design your Discount</h3>
                                <ul>
                                    <li class="select-wrap-container">
                                        <label >Discount Content</label>
                                        <div class="select-wrap">
                                            <select name="" id="select-discount-type" class="styled">
                                                <option value="">Choose Discount Type</option>
                                                <option value="">Discount Type 1</option>
                                            </select>
                                        </div>
                                        <div class="clear"></div>
                                    </li>
                                    <li>
                                        <label>Title</label>
                                        <input type="text" />
                                    </li>
                                    <li>
                                        <label>Description</label>
                                        <textarea cols="30" rows="10"></textarea>
                                       <div class="note">Max 250 characters</div>
                                    </li>
                                    <li>
                                        <label>Image</label>
                                        <input type="file" />
                                        <a href="" class="remove">Remove uploaded image</a>
                                    </li>
                                </ul>
                            </div>
                            <div class="discount-img">
                                <h6>Rotor Rooter, Inc.</h6>
                                <img src="" alt="Discount" height= "120px" />
                                <a href="">Download Image</a>
                            </div>
                        </fieldset>
                        
                        <fieldset>
                            <h3>Location</h3>
                            <ul>
                                <li class="select-wrap-container">
                                    <label >Market</label>
                                    <div class="select-wrap">
                                        <select id="dis_market" class="styled">
                                            <option value="">Select Market</option>
                                            <option value="Twin Cities">Twin Cities</option>
                                            <option value="Option 2">Option 2</option>
                                        </select>
                                    </div>
                                    <div class="clear"></div>
                                </li>
                            </ul>
                        </fieldset>
                          
                          <fieldset>
                               <h3>Scheduling</h3>
                               <ul>
                                   <li>
                                       <label>Start Date</label>
                                        <input type="text" class="date" />
                                   </li>
                                   <li>
                                       <label>End Date</label>
                                        <input type="text" class="date" />
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
