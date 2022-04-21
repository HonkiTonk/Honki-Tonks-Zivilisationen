pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GlobaleTexte;

package body AuswahlMenuesStringsSetzen is
   
   function AuswahlMenüEinfachStringSetzen
     (WelcheZeileExtern : in Positive;
      WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Haupt_Menü_Enum =>
            AktuellerText := GlobaleTexte.Hauptmenü (WelcheZeileExtern);
            
         when MenueDatentypen.Spiel_Menü_Enum =>
               AktuellerText := GlobaleTexte.Spielmenü (WelcheZeileExtern);
            
         when MenueDatentypen.Optionen_Menü_Enum =>
               AktuellerText := GlobaleTexte.Optionsmenü (WelcheZeileExtern);
            
         when MenueDatentypen.Kartengröße_Menü_Enum =>
               AktuellerText := GlobaleTexte.Kartengröße (WelcheZeileExtern);
            
         when MenueDatentypen.Kartenart_Menü_Enum =>
               AktuellerText := GlobaleTexte.Kartenart (WelcheZeileExtern);
            
         when MenueDatentypen.Kartenform_Menü_Enum =>
               AktuellerText := GlobaleTexte.Kartenform (WelcheZeileExtern);
            
         when MenueDatentypen.Kartentemperatur_Menü_Enum =>
               AktuellerText := GlobaleTexte.Kartentemperatur (WelcheZeileExtern);
            
         when MenueDatentypen.Kartenressourcen_Menü_Enum =>
               AktuellerText := GlobaleTexte.Ressourcenmenge (WelcheZeileExtern);
            
         when MenueDatentypen.Schwierigkeitsgrad_Menü_Enum =>
               AktuellerText := GlobaleTexte.Schwierigkeitsgrad (WelcheZeileExtern);
                        
         when MenueDatentypen.Rassen_Menü_Enum =>
               AktuellerText := GlobaleTexte.Rassenauswahl (WelcheZeileExtern);
            
         when MenueDatentypen.Grafik_Menü_Enum =>
               AktuellerText := GlobaleTexte.Grafikmenü (WelcheZeileExtern);
            
         when MenueDatentypen.Sound_Menü_Enum =>
               AktuellerText := GlobaleTexte.Soundmenü (WelcheZeileExtern);
            
         when MenueDatentypen.Sonstiges_Menü_Enum =>
               AktuellerText := GlobaleTexte.Sonstigesmenü (WelcheZeileExtern);
            
         when MenueDatentypen.Steuerung_Menü_Enum =>
               AktuellerText := GlobaleTexte.Steuerungmenü (WelcheZeileExtern);
            
         when MenueDatentypen.Editoren_Menü_Enum =>
            AktuellerText := GlobaleTexte.Editoren (WelcheZeileExtern);
            
         when MenueDatentypen.Einstellungen_Menü_Enum =>
            AktuellerText := GlobaleTexte.Einstellungsmenü (WelcheZeileExtern);
      end case;
            
      return To_Wide_Wide_String (Source => AktuellerText);
      
   end AuswahlMenüEinfachStringSetzen;
   
   
   
   function AuswahlMenüZusatztextStringSetzen
     (WelcheZeileExtern : in Positive;
      WelchesMenüExtern : in MenueDatentypen.Menü_Zusatztext_Enum)
      return Wide_Wide_String
   is begin
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Kartengröße_Menü_Enum =>
            AktuellerText := GlobaleTexte.Kartengröße (WelcheZeileExtern);

         when MenueDatentypen.Rassen_Menü_Enum =>
            AktuellerText := GlobaleTexte.Rassen (WelcheZeileExtern);
            
         when MenueDatentypen.Kartenform_Menü_Enum =>
            AktuellerText := GlobaleTexte.Kartenform (WelcheZeileExtern);
      end case;
      
      return To_Wide_Wide_String (Source => AktuellerText);
      
   end AuswahlMenüZusatztextStringSetzen;

end AuswahlMenuesStringsSetzen;
