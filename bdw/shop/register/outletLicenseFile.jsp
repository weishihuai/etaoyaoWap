
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--

如果选择三合一，则税务登记证、组织机构代码证两个基本证件不需要填写
营业执照有效期有长期，其他没有

需要根据客户选择的经营范围、企业类型，控制对应的证件进行显示。

门店资质 默认显示营业执照

--%>

<div class="cont-box aptitude">

    <div class="cb-mt">
        <label>资质文件上传</label>
    </div>
    <div class="cb-mc">

        <div class="item" id="licenseType" style="display: block">
            <label>证件类型</label>
            <div class="mrt">
                <div class="types"><label><input name="licenseType" id="isThreeInOne_N" type="radio"  onclick="return isThreeInOne('N')">普通营业执照</label>
                </div>
                <div class="types"><label><input name="licenseType" id="isThreeInOne_Y" type="radio"  onclick="return isThreeInOne('Y')">多证合一营业执照</label>
                </div>
            </div>
        </div>

        <%--营业执照副本--%>
        <div id="BusinessLicenseCertificate" class="licenseFile isNeed" style="display: block">
            <div class="item">
                <label  >营业执照副本<br>
                    及营业执照年检情况</label>
                <input type="hidden" id="BusinessLicenseCertificate_Nm"  value="营业执照副本及营业执照年检情况">
                <div class="mrt">
                    <%--<a id="BusinessLicenseCertificateTip"> </a>--%>
                    <div id="BusinessLicenseCertificateTipError" class="message"><i></i></div>
                    <p>需要在有效期内且年检章齐全，需为中国大陆工商局颁发。格式要求：支持.jpg、jpeg、bmp、gif、png格式照片,大小不超过2M</p>
                    <div class="pic-box" id="BusinessLicenseCertificate_file">
                        <div class="pic">
                            <a href="javascript:;" class="upload" id="BusinessLicenseCertificate_upload" >点击上传</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="item">
                <label>营业执照注册号</label>
                <div class="mrt">
                    <input type="text" id="BusinessLicenseCertificate_Num" placeholder="营业执照社会统一信用代码">
                </div>
            </div>
            <div class="item">
                <label>有效期</label>
                <div class="mrt">
                    <input id="BusinessLicenseCertificate_startDateString" class="isNeed" readonly="readonly" placeholder="点击选择时间"
                           onfocus="WdatePicker()" value="" type="text" style="width: 149px;">
                    <span>至</span>
                        <input id="BusinessLicenseCertificate_endDateString" class="isNeed" readonly="readonly" placeholder="点击选择时间"
                           onfocus="WdatePicker()" value="" type="text" style="width: 149px;">
                    <input id="BusinessLicenseCertificate_longTime" readonly="readonly" value="长期" type="text" style="width: 149px; display: none">
                    <label><input type="checkbox" id="BusinessLicenseCertificate_isLongTime">长期</label>
                </div>
            </div>
            <div class="line"></div>
        </div>


        <%--一般纳税人资质--%>
        <div id="TaxRegistrationCertificate" class="licenseFile" style="display: none">
            <div class="item">
                <label >一般纳税人资质</label>
                <input type="hidden" id="TaxRegistrationCertificate_Nm" value="一般纳税人资质">
                <div class="mrt">
                    <%--<a id="TaxRegistrationCertificateTip"> </a>--%>
                    <div id="TaxRegistrationCertificateTipError" class="message"><i></i></div>
                    <p>国税、地税均可，优先上传盖有国税局印章的税务登记证。格式要求：支持.jpg、jpeg、bmp、gif、png格式照片,大小不超过2M</p>
                    <div class="pic-box" id="TaxRegistrationCertificate_file">
                        <div class="pic">
                            <a href="javascript:;" class="upload" id="TaxRegistrationCertificate_upload">点击上传</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="item">
                <label>纳税人识别号</label>
                <div class="mrt">
                    <input type="text" id="TaxRegistrationCertificate_Num" placeholder="">
                </div>
            </div>
            <div class="line"></div>
        </div>


        <%--组织机构代码证--%>
        <div id="OrganizationCodeCertificate" class="licenseFile " style="display: none">
            <div class="item">
                <label >组织机构代码证</label>
                <input type="hidden" id="OrganizationCodeCertificate_Nm" value="组织机构代码证">
                <div class="mrt">
                    <%--<a id="OrganizationCodeCertificateTip"> </a>--%>
                    <div id="OrganizationCodeCertificateTipError" class="message"><i></i></div>
                    <p>组织机构代码证必须要年检，年检要求同营业执照年检要求一致，如果出现当地政策规定不定期（非正常年度）年检的情况，需出具政府发文文件的复印件并加盖供应商公章。格式要求：支持.jpg、jpeg、bmp、gif、png格式照片,大小不超过2M</p>
                    <div class="pic-box" id="OrganizationCodeCertificate_file">
                        <div class="pic">
                            <a href="javascript:;" class="upload" id="OrganizationCodeCertificate_upload">点击上传</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="item">
                <label>组织机构代码</label>
                <div class="mrt">
                    <input type="text" id="OrganizationCodeCertificate_Num" placeholder="">
                </div>
            </div>
            <div class="line"></div>
        </div>


        <%--互联网药品交易服务资格证--%>
        <div id="InternetDrugTradingServiceQualificationCertificate" class="licenseFile allowblank" style="display: none">
            <div class="item">
                <label  >互联网药品交易服务资格证</label>
                <input type="hidden" id="InternetDrugTradingServiceQualificationCertificate_Nm" value="互联网药品交易服务资格证">
                <div class="mrt">
                    <%--<a id="InternetDrugTradingServiceQualificationCertificateTip"> </a>--%>
                    <div id="InternetDrugTradingServiceQualificationCertificateTipError" class="message"><i></i></div>
                    <p>格式要求：支持.jpg、jpeg、bmp、gif、png格式照片,大小不超过2M</p>
                    <div class="pic-box" id="InternetDrugTradingServiceQualificationCertificate_file">
                        <div class="pic">
                            <a href="javascript:;" class="upload" id="InternetDrugTradingServiceQualificationCertificate_upload">点击上传</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="item">
                <label>证书号</label>
                <div class="mrt">
                    <input type="text" id="InternetDrugTradingServiceQualificationCertificate_Num" placeholder="">
                </div>
            </div>
            <div class="item">
                <label>有效期</label>
                <div class="mrt">
                    <input id="InternetDrugTradingServiceQualificationCertificate_startDateString" class="isNeed" readonly="readonly" placeholder="点击选择时间"
                           onfocus="WdatePicker()" value="" type="text" style="width: 149px;">
                    <span>至</span>
                    <input id="InternetDrugTradingServiceQualificationCertificate_endDateString" class="isNeed" readonly="readonly" placeholder="点击选择时间"
                           onfocus="WdatePicker()" value="" type="text" style="width: 149px;">
                </div>
            </div>
            <div class="line"></div>
        </div>

        <%--执业药师资格证--%>
        <div id="LicensedPharmacistQualificationCertificate" class="licenseFile " style="display: none">
            <div class="item">
                <label >执业药师资格证</label>
                <input type="hidden" id="LicensedPharmacistQualificationCertificate_Nm" value="执业药师资格证">
                <div class="mrt">
                    <%--<a id="LicensedPharmacistQualificationCertificateTip"> </a>--%>
                    <div id="LicensedPharmacistQualificationCertificateTipError" class="message"><i></i></div>
                    <p>格式要求：支持.jpg、jpeg、bmp、gif、png格式照片,大小不超过2M</p>
                    <div class="pic-box" id="LicensedPharmacistQualificationCertificate_file">
                        <div class="pic">
                            <a href="javascript:;" class="upload" id="LicensedPharmacistQualificationCertificate_upload">点击上传</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="item">
                <label>证书号</label>
                <div class="mrt">
                    <input type="text" id="LicensedPharmacistQualificationCertificate_Num" placeholder="">
                </div>
            </div>
            <div class="line"></div>
        </div>

        <%--药品生产许可证/药品经营许可证--%>
        <div id="DrugManufacturingCertificateOrBusinessLicense" class="licenseFile" style="display: none">
            <div class="item">
                <label  >药品生产许可证<br/>或药品经营许可证</label>
                <input type="hidden" id="DrugManufacturingCertificateOrBusinessLicense_Nm" value="药品生产许可证/药品经营许可证">
                <div class="mrt">
                    <%--<a id="DrugManufacturingCertificateOrBusinessLicenseTip"> </a>--%>
                    <div id="DrugManufacturingCertificateOrBusinessLicenseTipError" class="message"><i></i></div>
                    <p>格式要求：支持.jpg、jpeg、bmp、gif、png格式照片,大小不超过2M</p>
                    <div class="pic-box" id="DrugManufacturingCertificateOrBusinessLicense_file">
                        <div class="pic">
                            <a href="javascript:;" class="upload" id="DrugManufacturingCertificateOrBusinessLicense_upload">点击上传</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="item">
                <label>证书号</label>
                <div class="mrt">
                    <input type="text" id="DrugManufacturingCertificateOrBusinessLicense_Num" placeholder="">
                </div>
            </div>
            <div class="item">
                <label>有效期</label>
                <div class="mrt">
                    <input id="DrugManufacturingCertificateOrBusinessLicense_startDateString" class="isNeed" readonly="readonly" placeholder="点击选择时间"
                           onfocus="WdatePicker()" value="" type="text" style="width: 149px;">
                    <span>至</span>
                    <input id="DrugManufacturingCertificateOrBusinessLicense_endDateString" class="isNeed" readonly="readonly" placeholder="点击选择时间"
                           onfocus="WdatePicker()" value="" type="text" style="width: 149px;">
                </div>
            </div>
            <div class="line"></div>
        </div>


        <%--GSP/GMP证书--%>
        <div id="GSPOrGMPCertificate" class="licenseFile" style="display: none">
            <div class="item">
                <label >GSP证书<br/>或GMP证书</label>
                <input type="hidden" id="GSPOrGMPCertificate_Nm" value="GSP证书/GMP证书">
                <div class="mrt">
                    <%--<a id="GSPOrGMPCertificateTip"> </a>--%>
                    <div id="GSPOrGMPCertificateTipError" class="message"><i></i></div>
                    <p>格式要求：支持.jpg、jpeg、bmp、gif、png格式照片,大小不超过2M</p>
                    <div class="pic-box" id="GSPOrGMPCertificate_file">
                        <div class="pic">
                            <a href="javascript:;" class="upload"  id="GSPOrGMPCertificate_upload">点击上传</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="item">
                <label>证书号</label>
                <div class="mrt">
                    <input type="text" id="GSPOrGMPCertificate_Num" placeholder="">
                </div>
            </div>
            <div class="item">
                <label>有效期</label>
                <div class="mrt">
                    <input id="GSPOrGMPCertificate_startDateString" class="isNeed" readonly="readonly" placeholder="点击选择时间"
                           onfocus="WdatePicker()" value="" type="text" style="width: 149px;">
                    <span>至</span>
                    <input id="GSPOrGMPCertificate_endDateString" class="isNeed" readonly="readonly" placeholder="点击选择时间"
                           onfocus="WdatePicker()" value="" type="text" style="width: 149px;">
                </div>
            </div>
            <div class="line"></div>
        </div>


        <%--医疗器械生产许可证/医疗器械经营许可证--%>
        <div id="MedicalDevicesManufacturingLicenseOrBusinessLicense" class="licenseFile" style="display: none">
            <div class="item">
                <label >医疗器械生产许可证<br/>或医疗器械经营许可证</label>
                <input type="hidden" id="MedicalDevicesManufacturingLicenseOrBusinessLicense_Nm" value="医疗器械生产许可证/医疗器械经营许可证">
                <div class="mrt">
                    <%--<a id="MedicalDevicesManufacturingLicenseOrBusinessLicenseTip"> </a>--%>
                    <div id="MedicalDevicesManufacturingLicenseOrBusinessLicenseTipError" class="message"><i></i></div>
                    <p>格式要求：支持.jpg、jpeg、bmp、gif、png格式照片,大小不超过2M</p>
                    <div class="pic-box" id="MedicalDevicesManufacturingLicenseOrBusinessLicense_file">
                        <div class="pic">
                            <a href="javascript:;" class="upload" id="MedicalDevicesManufacturingLicenseOrBusinessLicense_upload">点击上传</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="item">
                <label>证书号</label>
                <div class="mrt">
                    <input type="text" id="MedicalDevicesManufacturingLicenseOrBusinessLicense_Num" placeholder="">
                </div>
            </div>
            <div class="item">
                <label>有效期</label>
                <div class="mrt">
                    <input id="MedicalDevicesManufacturingLicenseOrBusinessLicense_startDateString" class="isNeed" readonly="readonly" placeholder="点击选择时间"
                           onfocus="WdatePicker()" value="" type="text" style="width: 149px;">
                    <span>至</span>
                    <input id="MedicalDevicesManufacturingLicenseOrBusinessLicense_endDateString" class="isNeed" readonly="readonly" placeholder="点击选择时间"
                           onfocus="WdatePicker()" value="" type="text" style="width: 149px;">
                </div>
            </div>
            <div class="line"></div>
        </div>



        <%--食品生产许可证/食品经营许可证/食品流通许可证--%>
        <div id="FoodProductionLicenseOrBusinessLicenseOrCirculationLicense" class="licenseFile" style="display: none">
            <div class="item">
                <label>食品生产许可证<br/>或食品经营许可证<br/>或食品流通许可证</label>
                <input type="hidden" id="FoodProductionLicenseOrBusinessLicenseOrCirculationLicense_Nm" value="食品生产许可证/食品经营许可证/食品流通许可证">
                <div class="mrt">
                    <%--<a id="FoodProductionLicenseOrBusinessLicenseOrCirculationLicenseTip"> </a>--%>
                    <div id="FoodProductionLicenseOrBusinessLicenseOrCirculationLicenseTipError" class="message"><i></i></div>
                    <p>格式要求：支持.jpg、jpeg、bmp、gif、png格式照片,大小不超过2M</p>
                    <div class="pic-box" id="FoodProductionLicenseOrBusinessLicenseOrCirculationLicense_file">
                        <div class="pic">
                            <a href="javascript:;" class="upload" id="FoodProductionLicenseOrBusinessLicenseOrCirculationLicense_upload">点击上传</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="item">
                <label>证书号</label>
                <div class="mrt">
                    <input type="text" id="FoodProductionLicenseOrBusinessLicenseOrCirculationLicense_Num" placeholder="">
                </div>
            </div>
            <div class="item">
                <label>有效期</label>
                <div class="mrt">
                    <input id="FoodProductionLicenseOrBusinessLicenseOrCirculationLicense_startDateString" class="isNeed" readonly="readonly" placeholder="点击选择时间"
                           onfocus="WdatePicker()" value="" type="text" style="width: 149px;">
                    <span>至</span>
                    <input id="FoodProductionLicenseOrBusinessLicenseOrCirculationLicense_endDateString" class="isNeed" readonly="readonly" placeholder="点击选择时间"
                           onfocus="WdatePicker()" value="" type="text" style="width: 149px;">
                </div>
            </div>
            <div class="line"></div>
        </div>



        <%--食品卫生许可证--%>
        <div id="FoodHygieneLicense" class="licenseFile" style="display: none">
            <div class="item">
                <label  >食品卫生许可证</label>
                <input type="hidden" id="FoodHygieneLicense_Nm" value="食品卫生许可证">
                <div class="mrt">
                    <%--<a id="FoodHygieneLicenseTip"> </a>--%>
                    <div id="FoodHygieneLicenseTipError" class="message"><i></i></div>
                    <p>格式要求：支持.jpg、jpeg、bmp、gif、png格式照片,大小不超过2M</p>
                    <div class="pic-box" id="FoodHygieneLicense_file">
                        <div class="pic">
                            <a href="javascript:;" class="upload" id="FoodHygieneLicense_upload">点击上传</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="item">
                <label>证书号</label>
                <div class="mrt">
                    <input type="text" id="FoodHygieneLicense_Num" placeholder="">
                </div>
            </div>
            <div class="item">
                <label>有效期</label>
                <div class="mrt">
                    <input id="FoodHygieneLicense_startDateString" class="isNeed" readonly="readonly" placeholder="点击选择时间"
                           onfocus="WdatePicker()" value="" type="text" style="width: 149px;">
                    <span>至</span>
                    <input id="FoodHygieneLicense_endDateString" class="isNeed" readonly="readonly" placeholder="点击选择时间"
                           onfocus="WdatePicker()" value="" type="text" style="width: 149px;">
                </div>
            </div>
            <div class="line"></div>
        </div>



         <%--化妆品生产企业卫生许可证--%>
        <div id="HygieneLicenseForCosmeticsManufacturers" class="licenseFile" style="display: none">
            <div class="item">
                <label >化妆品生产企业卫生许可证</label>
                <input type="hidden" id="HygieneLicenseForCosmeticsManufacturers_Nm" value="化妆品生产企业卫生许可证">
                <div class="mrt">
                    <%--<a id="HygieneLicenseForCosmeticsManufacturersTip"> </a>--%>
                    <div id="HygieneLicenseForCosmeticsManufacturersTipError" class="message"><i></i></div>
                    <p>格式要求：支持.jpg、jpeg、bmp、gif、png格式照片,大小不超过2M</p>
                    <div class="pic-box" id="HygieneLicenseForCosmeticsManufacturers_file">
                        <div class="pic">
                            <a href="javascript:;" class="upload" id="HygieneLicenseForCosmeticsManufacturers_upload">点击上传</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="item">
                <label>证书号</label>
                <div class="mrt">
                    <input type="text" id="HygieneLicenseForCosmeticsManufacturers_Num" placeholder="">
                </div>
            </div>
            <div class="item">
                <label>有效期</label>
                <div class="mrt">
                    <input id="HygieneLicenseForCosmeticsManufacturers_startDateString" class="isNeed" readonly="readonly" placeholder="点击选择时间"
                           onfocus="WdatePicker()" value="" type="text" style="width: 149px;">
                    <span>至</span>
                    <input id="HygieneLicenseForCosmeticsManufacturers_endDateString" class="isNeed" readonly="readonly" placeholder="点击选择时间"
                           onfocus="WdatePicker()" value="" type="text" style="width: 149px;">
                </div>
            </div>
            <div class="line"></div>
        </div>



         <%--全国工业产品生产许可证--%>
        <div id="NationalIndustrialProductProductionPermit" class="licenseFile" style="display: none">
            <div class="item">
                <label  >全国工业产品生产许可证</label>
                <input type="hidden" id="NationalIndustrialProductProductionPermit_Nm" value="全国工业产品生产许可证">
                <div class="mrt">
                    <%--<a id="NationalIndustrialProductProductionPermitTip"> </a>--%>
                    <div id="NationalIndustrialProductProductionPermitTipError" class="message"><i></i></div>
                    <p>格式要求：支持.jpg、jpeg、bmp、gif、png格式照片,大小不超过2M</p>
                    <div class="pic-box" id="NationalIndustrialProductProductionPermit_file">
                        <div class="pic">
                            <a href="javascript:;" class="upload"  id="NationalIndustrialProductProductionPermit_upload">点击上传</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="item">
                <label>证书号</label>
                <div class="mrt">
                    <input type="text" id="NationalIndustrialProductProductionPermit_Num" placeholder="">
                </div>
            </div>
            <div class="item">
                <label>有效期</label>
                <div class="mrt">
                    <input id="NationalIndustrialProductProductionPermit_startDateString" class="isNeed" readonly="readonly" placeholder="点击选择时间"
                           onfocus="WdatePicker()" value="" type="text" style="width: 149px;">
                    <span>至</span>
                    <input id="NationalIndustrialProductProductionPermit_endDateString" class="isNeed" readonly="readonly" placeholder="点击选择时间"
                           onfocus="WdatePicker()" value="" type="text" style="width: 149px;">
                </div>
            </div>
            <div class="line"></div>
        </div>



        <%--消毒用品生产企业卫生许可证--%>
        <div id="HygienicLicenseForEnterprisesProducingSterilizedArticles" class="licenseFile" style="display: none">
            <div class="item">
                <label  >消毒用品生产企业卫生许可证</label>
                <input type="hidden" id="HygienicLicenseForEnterprisesProducingSterilizedArticles_Nm" value="消毒用品生产企业卫生许可证">
                <div class="mrt">
                    <%--<a id="HygienicLicenseForEnterprisesProducingSterilizedArticlesTip"> </a>--%>
                    <div id="HygienicLicenseForEnterprisesProducingSterilizedArticlesTipError" class="message"><i></i></div>
                    <p>格式要求：支持.jpg、jpeg、bmp、gif、png格式照片,大小不超过2M</p>
                    <div class="pic-box" id="HygienicLicenseForEnterprisesProducingSterilizedArticles_file">
                        <div class="pic">
                            <a href="javascript:;" class="upload"  id="HygienicLicenseForEnterprisesProducingSterilizedArticles_upload">点击上传</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="item">
                <label>证书号</label>
                <div class="mrt">
                    <input type="text" id="HygienicLicenseForEnterprisesProducingSterilizedArticles_Num" placeholder="">
                </div>
            </div>
            <div class="item">
                <label>有效期</label>
                <div class="mrt">
                    <input id="HygienicLicenseForEnterprisesProducingSterilizedArticles_startDateString" class="isNeed" readonly="readonly" placeholder="点击选择时间"
                           onfocus="WdatePicker()" value="" type="text" style="width: 149px;">
                    <span>至</span>
                    <input id="HygienicLicenseForEnterprisesProducingSterilizedArticles_endDateString" class="isNeed" readonly="readonly" placeholder="点击选择时间"
                           onfocus="WdatePicker()" value="" type="text" style="width: 149px;">
                </div>
            </div>
            <div class="line"></div>
        </div>

    </div>
</div>

