<?php include('assets/includes/header.php'); ?>
            <div id="content">
                <h2>Company: Rotor Rooter Inc.</h2>
                <div class="col-a col">
                    <div class="sidebar-nav">
                        <ul>
                            <li><a href="">Basic Info</a></li>
                            <li class="active"><a href="">Service Info</a></li>
                            <li><a href="">Credentials</a></li>
                            <li><a href="">Alerts</a></li>
                            <li><a href="">Discounts</a></li>
                        </ul>
                    </div><!-- closes sidebar nav -->
                </div><!-- closes col a -->
                <div class="col-b col">
                    <form action="">
                        <fieldset>
                            <h3>Business Description</h3>
                            <ul>
                                <li>
                                    <label >About</label>
                                    <input type="text" />
                                </li>
                                <li>
                                    <label >Description</label>
                                    <textarea cols="30" rows="10"></textarea>
                                    <div class="note">Max XXX Characters</div>
                                </li>
                                <li>
                                    <label >General Info</label>
                                    <textarea cols="30" rows="10"></textarea>
                                    <div class="note">Max XXX Characters</div>
                                </li>
                            </ul>
                        </fieldset>
                        
                        <fieldset>
                             <h3>Service Area</h3>
                             <ul>
                                 <li class="select-wrap-container">
                                     <label>Market</label>
                                     <div class="select-wrap">
                                         <select name="" id="select-market" class="styled">
                                            <option value="">Select Market</option>
                                            <option value="">Twin Cities</option>
                                            <option value="">Other</option>
                                         </select>
                                     </div>
                                     <div class="clear"></div>
                                 </li>
                                 <li class="radio-options radio-1">
                                     <label class="main-label">Region &amp; Coverage <span>(select all that apply)</span></label>
                                     <div class="checkbox-wrap">
                                        <input type="checkbox" id="select-all-options"  />
                                        <label class="select-all">Select All</label>
                                     </div>
                                     <div class="checkbox-wrap">
                                        <input id="anoka" class="checkbox" type="checkbox" />
                                        <label for="anoka">Anoka</label>
                                     </div>
                                     <div id="radio-btn1" class="radio disabled radio1">               
                                        <input type="radio" id="radio-anoka1" name="radio1" disabled="disabled" checked="checked" />
                                        <label for="radio-anoka1">All</label>
                                        <input type="radio" id="radio-anoka2" name="radio1" disabled="disabled" />
                                        <label for="radio-anoka2">Partial</label>            
                                     </div>
                                     
                                 </li>
                                 <li class="radio-options">

                                     <div class="checkbox-wrap">
                                        <input type="checkbox" id="carver" class="checkbox" />
                                        <label for="carver">Carver</label>
                                     </div>
                                     <div class="radio disabled radio2">               
                                        <input type="radio" id="radio-carver1" name="radio2" disabled="disabled" checked="checked" />
                                        <label for="radio-carver1">All</label>
                                        <input type="radio" id="radio-carver2" disabled="disabled" name="radio2" />
                                        <label for="radio-carver2">Partial</label>            
                                     </div>
                                     
                                 </li>
                                 <li class="radio-options">

                                     <div class="checkbox-wrap">
                                        <input type="checkbox" class="checkbox" id="dakota" />
                                        <label for="dakota">Dakota</label>
                                     </div>
                                     <div class="radio disabled radio3">               
                                        <input type="radio" id="radio-dakota1" disabled="disabled" name="radio3" checked="checked" />
                                        <label for="radio-dakota1">All</label>
                                        <input type="radio" id="radio-dakota2" disabled="disabled" name="radio3" />
                                        <label for="radio-dakota2">Partial</label>            
                                     </div>
                                     
                                 </li>
                                 <li class="radio-options">

                                     <div class="checkbox-wrap">
                                        <input id="ramsey" class="checkbox" type="checkbox" />
                                        <label for="ramsey">Ramsey</label>
                                     </div>
                                     <div class="radio disabled radio4">               
                                        <input type="radio" id="radio-ramsey1" disabled="disabled" name="radio5" checked="checked" />
                                        <label for="radio-ramsey1">All</label>
                                        <input type="radio" id="radio-ramsey2" disabled="disabled" name="radio5" />
                                        <label for="radio-ramsey2">Partial</label>            
                                     </div>
                                 </li>
                                 <li class="radio-options">
                                     <div class="checkbox-wrap">
                                        <input id="scott" class="checkbox" type="checkbox" />
                                        <label for="scott">Scott</label>
                                     </div>
                                     <div class="radio disabled radio4">               
                                        <input type="radio" id="radio-Scott1" disabled="disabled" name="radio4" checked="checked" />
                                        <label for="radio-Scott1">All</label>
                                        <input type="radio" id="radio-Scott2" disabled="disabled" name="radio4" />
                                        <label for="radio-Scott2">Partial</label>            
                                     </div>
                                 </li>
                                 <li class="radio-options">

                                     <div class="checkbox-wrap">
                                        <input id="sherburne" class="checkbox" type="checkbox" />
                                        <label for="sherburne">Sherburne</label>
                                     </div>
                                     <div class="radio disabled radio4">               
                                        <input type="radio" id="radio-sherburne1" disabled="disabled" name="radio7" checked="checked" />
                                        <label for="radio-sherburne1">All</label>
                                        <input type="radio" id="radio-sherburne2" disabled="disabled" name="radio7" />
                                        <label for="radio-sherburne2">Partial</label>            
                                     </div>
                                 </li>
                                 <li class="radio-options">

                                     <div class="checkbox-wrap">
                                        <input id="washington" class="checkbox" type="checkbox" />
                                        <label for="washington">Washington</label>
                                     </div>
                                     <div class="radio disabled radio4">               
                                        <input type="radio" id="radio-washington1" disabled="disabled" name="radio8" checked="checked" />
                                        <label for="radio-washington1">All</label>
                                        <input type="radio" id="radio-washington2" disabled="disabled" name="radio8" />
                                        <label for="radio-washington2">Partial</label>            
                                     </div>
                                 </li>
                                 <li class="radio-options">

                                     <div class="checkbox-wrap">
                                        <input id="wright" class="checkbox" type="checkbox" />
                                        <label for="wright">Wright</label>
                                     </div>
                                     <div class="radio disabled radio4">               
                                        <input type="radio" id="radio-wright1" disabled="disabled" name="radio9" checked="checked" />
                                        <label for="radio-wright1">All</label>
                                        <input type="radio" id="radio-wright2" disabled="disabled" name="radio9"  />
                                        <label for="radio-wright2">Partial</label>            
                                     </div>
                                 </li>
                            </ul>
                         </fieldset>
                         
                           <fieldset class="alt-section ">
                                <h3>Service Category</h3>
                                <ul>
                                    <li>
                                        <div class="search-filter">
                                            <div class="select-wrap">
                                                <select name="" id="provider-category" class="styled">
                                                    <option value="Select Category">Select Category</option>
                                                </select>
                                            </div>
                                            <div class="select-wrap">
                                                <select name="" id="provider-subcategory" disabled="disabled" class="styled">
                                                    <option value="Select Category">Select Sub-Category</option>
                                                </select>
                                            </div>
                                            <a href="" class="search-filter-delete">Delete</a>
                                            <div class="clear"></div>
                                        </div><!-- closes search filter -->
                                    </li>
                                    <li>
                                        <a href="" class="add">Add a Service Category</a>
                                    </li>
                                </ul>
                            </fieldset>
                            <fieldset>
                                <h3>Operations</h3>
                                <ul>
                                    <li class="radio-options">
                                        <label class="btn-label">24 hr Service</label>
                                        <div class="radio">               
                                           <input type="radio" id="radio-yes-hrs" name="button-hrs" />
                                           <label for="radio-yes-hrs">Yes</label>
                                           <input type="radio" id="radio-no-hrs" name="button-hrs" checked="checked" />
                                           <label for="radio-no-hrs">No</label>            
                                        </div>
                                    </li>
                                    <li class="radio-options">
                                        <label class="btn-label">Emergency Services</label>
                                        <div class="radio">               
                                           <input type="radio" id="radio-yes-emerg" name="button-emerg" checked="checked" />
                                           <label for="radio-yes-emerg">Yes</label>
                                           <input type="radio" id="radio-no-emerg" name="button-emerg" />
                                           <label for="radio-no-emerg">No</label>            
                                        </div>
                                    </li>
                                </ul>
                            </fieldset>
                            <fieldset class="last">
                                <a href="#" class="cancel">Cancel</a>
                                 <input type="submit" value="Save" class="save" />
                             </fieldset>
                    </form>
                </div><!-- closes col b -->
<?php include('assets/includes/footer.php'); ?>
