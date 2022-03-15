pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;
with KartenDatentypen;

package KartenEinstellungenKonstanten is

   Kartengröße2020Konstante : constant KartenDatentypen.Kartengröße_Standard_Enum := SystemDatentypen.Karte_Größe_20_20;
   Kartengröße4040Konstante : constant KartenDatentypen.Kartengröße_Standard_Enum := SystemDatentypen.Karte_Größe_40_40;
   Kartengröße8080Konstante : constant KartenDatentypen.Kartengröße_Standard_Enum := SystemDatentypen.Karte_Größe_80_80;
   Kartengröße12080Konstante : constant KartenDatentypen.Kartengröße_Standard_Enum := SystemDatentypen.Karte_Größe_120_80;
   Kartengröße120160Konstante : constant KartenDatentypen.Kartengröße_Standard_Enum := SystemDatentypen.Karte_Größe_120_160;
   Kartengröße160160Konstante : constant KartenDatentypen.Kartengröße_Standard_Enum := SystemDatentypen.Karte_Größe_160_160;
   Kartengröße240240Konstante : constant KartenDatentypen.Kartengröße_Standard_Enum := SystemDatentypen.Karte_Größe_240_240;
   Kartengröße320320Konstante : constant KartenDatentypen.Kartengröße_Standard_Enum := SystemDatentypen.Karte_Größe_320_320;
   Kartengröße10001000Konstante : constant KartenDatentypen.Kartengröße_Standard_Enum := SystemDatentypen.Karte_Größe_1000_1000;
   KartengrößeNutzerKonstante : constant KartenDatentypen.Kartengröße_Verwendet_Enum := SystemDatentypen.Karte_Größe_Nutzer;
   KartengrößeZufallKonstante : constant KartenDatentypen.Kartengröße_Enum := SystemDatentypen.Karte_Größe_Zufall;
   
   KartenartInselnKonstante : constant KartenDatentypen.Kartenart_Verwendet_Enum := SystemDatentypen.Karte_Art_Inseln;
   KartenartKontinenteKonstante : constant KartenDatentypen.Kartenart_Verwendet_Enum := SystemDatentypen.Karte_Art_Kontinente;
   KartenartPangäaKonstante : constant KartenDatentypen.Kartenart_Verwendet_Enum := SystemDatentypen.Karte_Art_Pangäa;
   KartenartLandKonstante : constant KartenDatentypen.Kartenart_Verwendet_Enum := SystemDatentypen.Karte_Art_Nur_Land;
   KartenartChaosKonstante : constant KartenDatentypen.Kartenart_Verwendet_Enum := SystemDatentypen.Karte_Art_Chaos;
   
   KartenformXZylinderKonstante : constant KartenDatentypen.Kartenform_Verwendet_Enum := SystemDatentypen.Karte_Form_X_Zylinder;
   KartenformYZylinderKonstante : constant KartenDatentypen.Kartenform_Verwendet_Enum := SystemDatentypen.Karte_Form_Y_Zylinder;
   KartenformTorusKonstante : constant KartenDatentypen.Kartenform_Verwendet_Enum := SystemDatentypen.Karte_Form_Torus;
   KartenformKugelKonstante : constant KartenDatentypen.Kartenform_Verwendet_Enum := SystemDatentypen.Karte_Form_Kugel;
   KartenformViereckKonstante : constant KartenDatentypen.Kartenform_Verwendet_Enum := SystemDatentypen.Karte_Form_Viereck;
   KartenformKugelGedrehtKonstante : constant KartenDatentypen.Kartenform_Verwendet_Enum := SystemDatentypen.Karte_Form_Kugel_Gedreht;
   KartenformTugelKonstante : constant KartenDatentypen.Kartenform_Verwendet_Enum := SystemDatentypen.Karte_Form_Tugel;
   KartenformTugelGedrehtKonstante : constant KartenDatentypen.Kartenform_Verwendet_Enum := SystemDatentypen.Karte_Form_Tugel_Gedreht;
   KartenformTugelExtremKonstante : constant KartenDatentypen.Kartenform_Verwendet_Enum := SystemDatentypen.Karte_Form_Tugel_Extrem;
   
   KartenformKeinÜbergangEAchseKonstante : constant KartenDatentypen.Kartenform_E_Achse_Einstellbar_Enum := SystemDatentypen.Karte_E_Achse_Kein_Übergang;
   KartenformÜbergangEAchseKonstante : constant KartenDatentypen.Kartenform_E_Achse_Einstellbar_Enum := SystemDatentypen.Karte_E_Achse_Übergang;
   
   KartenformKeinÜbergangYAchseKonstante : constant KartenDatentypen.Kartenform_Y_Achse_Einstellbar_Enum := SystemDatentypen.Karte_Y_Achse_Kein_Übergang;
   KartenformÜbergangYAchseKonstante : constant KartenDatentypen.Kartenform_Y_Achse_Einstellbar_Enum := SystemDatentypen.Karte_Y_Achse_Übergang;
   KartenformRückwärtsVerschobenerÜbergangYAchseKonstante : constant KartenDatentypen.Kartenform_Y_Achse_Einstellbar_Enum := SystemDatentypen.Karte_Y_Achse_Rückwärts_Verschobener_Übergang;
   KartenformÜbergangYAchseVerschobenKonstante : constant KartenDatentypen.Kartenform_Y_Achse_Einstellbar_Enum := SystemDatentypen.Karte_Y_Achse_Verschobener_Übergang;
   
   KartenformKeinÜbergangXAchseKonstante : constant KartenDatentypen.Kartenform_X_Achse_Einstellbar_Enum := SystemDatentypen.Karte_X_Achse_Kein_Übergang;
   KartenformÜbergangXAchseKonstante : constant KartenDatentypen.Kartenform_X_Achse_Einstellbar_Enum := SystemDatentypen.Karte_X_Achse_Übergang;
   KartenformRückwärtsVerschobenerÜbergangXAchseKonstante : constant KartenDatentypen.Kartenform_X_Achse_Einstellbar_Enum := SystemDatentypen.Karte_X_Achse_Rückwärts_Verschobener_Übergang;
   KartenformÜbergangXAchseVerschobenKonstante : constant KartenDatentypen.Kartenform_X_Achse_Einstellbar_Enum := SystemDatentypen.Karte_X_Achse_Verschobener_Übergang;
         
   TemperaturKaltKonstante : constant KartenDatentypen.Kartentemperatur_Verwendet_Enum := SystemDatentypen.Karte_Temperatur_Kalt;
   TemperaturGemäßigtKonstante : constant KartenDatentypen.Kartentemperatur_Verwendet_Enum := SystemDatentypen.Karte_Temperatur_Gemäßigt;
   TemperaturHeißKonstante : constant KartenDatentypen.Kartentemperatur_Verwendet_Enum := SystemDatentypen.Karte_Temperatur_Heiß;
   TemperaturEiszeitKonstante : constant KartenDatentypen.Kartentemperatur_Verwendet_Enum := SystemDatentypen.Karte_Temperatur_Eiszeit;
   TemperaturWüsteKonstante : constant KartenDatentypen.Kartentemperatur_Verwendet_Enum := SystemDatentypen.Karte_Temperatur_Wüste;
   
   RessourcenArmKonstante : constant KartenDatentypen.Kartenressourcen_Verwendet_Enum := SystemDatentypen.Karte_Ressource_Arm;
   RessourcenWenigKonstante : constant KartenDatentypen.Kartenressourcen_Verwendet_Enum := SystemDatentypen.Karte_Ressource_Wenig;
   RessourcenMittelKonstante : constant KartenDatentypen.Kartenressourcen_Verwendet_Enum := SystemDatentypen.Karte_Ressource_Mittel;
   RessourcenVielKonstante : constant KartenDatentypen.Kartenressourcen_Verwendet_Enum := SystemDatentypen.Karte_Ressource_Viel;
   RessourcenÜberflussKonstante : constant KartenDatentypen.Kartenressourcen_Verwendet_Enum := SystemDatentypen.Karte_Ressource_Überfluss;

end KartenEinstellungenKonstanten;
