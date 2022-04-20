pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GlobaleTexte;

package body AuswahlMenuesStringsSetzen is
   
   function StringSetzen
     (WelcheZeileExtern : in Positive;
      WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
      
      case
        WelchesMenüExtern
      is
         when SystemDatentypen.Haupt_Menü_Enum =>
            AktuellerText := GlobaleTexte.Hauptmenü (WelcheZeileExtern);
            
         when SystemDatentypen.Spiel_Menü_Enum =>
               AktuellerText := GlobaleTexte.Spielmenü (WelcheZeileExtern);
            
         when SystemDatentypen.Optionen_Menü_Enum =>
               AktuellerText := GlobaleTexte.Optionsmenü (WelcheZeileExtern);
            
         when SystemDatentypen.Kartengröße_Menü_Enum =>
               AktuellerText := GlobaleTexte.Kartengröße (WelcheZeileExtern);
            
         when SystemDatentypen.Kartenart_Menü_Enum =>
               AktuellerText := GlobaleTexte.Kartenart (WelcheZeileExtern);
            
         when SystemDatentypen.Kartenform_Menü_Enum =>
               AktuellerText := GlobaleTexte.Kartenform (WelcheZeileExtern);
            
         when SystemDatentypen.Kartentemperatur_Menü_Enum =>
               AktuellerText := GlobaleTexte.Kartentemperatur (WelcheZeileExtern);
            
         when SystemDatentypen.Kartenressourcen_Menü_Enum =>
               AktuellerText := GlobaleTexte.Ressourcenmenge (WelcheZeileExtern);
            
         when SystemDatentypen.Schwierigkeitsgrad_Menü_Enum =>
               AktuellerText := GlobaleTexte.Schwierigkeitsgrad (WelcheZeileExtern);
                        
         when SystemDatentypen.Rassen_Menü_Enum =>
               AktuellerText := GlobaleTexte.Rassenauswahl (WelcheZeileExtern);
            
         when SystemDatentypen.Grafik_Menü_Enum =>
               AktuellerText := GlobaleTexte.Grafikmenü (WelcheZeileExtern);
            
         when SystemDatentypen.Sound_Menü_Enum =>
               AktuellerText := GlobaleTexte.Soundmenü (WelcheZeileExtern);
            
         when SystemDatentypen.Sonstiges_Menü_Enum =>
               AktuellerText := GlobaleTexte.Sonstigesmenü (WelcheZeileExtern);
            
         when SystemDatentypen.Steuerung_Menü_Enum =>
               AktuellerText := GlobaleTexte.Steuerungmenü (WelcheZeileExtern);
            
         when SystemDatentypen.Editoren_Menü_Enum =>
            AktuellerText := GlobaleTexte.Editoren (WelcheZeileExtern);
            
         when SystemDatentypen.Einstellungen_Menü_Enum =>
            AktuellerText := GlobaleTexte.Einstellungsmenü (WelcheZeileExtern);
      end case;
            
      return To_Wide_Wide_String (Source => AktuellerText);
      
   end StringSetzen;
   
   
   
   function RassenbeschreibungSetzen
     (WelcheZeileExtern : in Positive)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => GlobaleTexte.Rassen (WelcheZeileExtern));
      
   end RassenbeschreibungSetzen;

end AuswahlMenuesStringsSetzen;
