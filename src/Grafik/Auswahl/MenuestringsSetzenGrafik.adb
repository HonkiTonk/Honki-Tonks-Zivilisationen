with Menuetexte;

package body MenuestringsSetzenGrafik is
   
   function MenüstringsSetzen
     (WelcheZeileExtern : in Positive;
      WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Haupt_Menü_Enum =>
            AktuellerText := Menuetexte.Hauptmenü (WelcheZeileExtern);
            
         when MenueDatentypen.Spiel_Menü_Enum =>
            AktuellerText := Menuetexte.Spielmenü (WelcheZeileExtern);
            
         when MenueDatentypen.Optionen_Menü_Enum =>
            AktuellerText := Menuetexte.Optionsmenü (WelcheZeileExtern);
            
         when MenueDatentypen.Kartenpole_Menü_Enum =>
            AktuellerText := Menuetexte.Kartenpole (WelcheZeileExtern);
            
         when MenueDatentypen.Kartengröße_Menü_Enum =>
            AktuellerText := Menuetexte.Kartengröße (WelcheZeileExtern);
            
         when MenueDatentypen.Kartenart_Menü_Enum =>
            AktuellerText := Menuetexte.Kartenart (WelcheZeileExtern);
            
         when MenueDatentypen.Kartenform_Menü_Enum =>
            AktuellerText := Menuetexte.Kartenform (WelcheZeileExtern);
            
         when MenueDatentypen.Kartentemperatur_Menü_Enum =>
            AktuellerText := Menuetexte.Kartentemperatur (WelcheZeileExtern);
            
         when MenueDatentypen.Kartenressourcen_Menü_Enum =>
            AktuellerText := Menuetexte.Ressourcenmenge (WelcheZeileExtern);
            
         when MenueDatentypen.Schwierigkeitsgrad_Menü_Enum =>
            AktuellerText := Menuetexte.Schwierigkeitsgrad (WelcheZeileExtern);
                        
         when MenueDatentypen.Spezies_Menü_Enum =>
            AktuellerText := Menuetexte.Speziesauswahl (WelcheZeileExtern);
            
         when MenueDatentypen.Grafik_Menü_Enum =>
            AktuellerText := Menuetexte.Grafikmenü (WelcheZeileExtern);
            
         when MenueDatentypen.Sound_Menü_Enum =>
            AktuellerText := Menuetexte.Soundmenü (WelcheZeileExtern);
            
         when MenueDatentypen.Sonstiges_Menü_Enum =>
            AktuellerText := Menuetexte.Sonstigesmenü (WelcheZeileExtern);
            
         when MenueDatentypen.Steuerung_Menü_Enum =>
            AktuellerText := Menuetexte.Steuerungmenü (WelcheZeileExtern);
            
         when MenueDatentypen.Editoren_Menü_Enum =>
            AktuellerText := Menuetexte.Editoren (WelcheZeileExtern);
            
         when MenueDatentypen.Einstellungen_Menü_Enum =>
            AktuellerText := Menuetexte.Einstellungsmenü (WelcheZeileExtern);
            
         when MenueDatentypen.Debug_Menü_Enum =>
            AktuellerText := Menuetexte.Debugmenü (WelcheZeileExtern);
            
         when MenueDatentypen.Diplomatie_Menü_Enum =>
            AktuellerText := Menuetexte.Diplomatiemenü (WelcheZeileExtern);
            
         when MenueDatentypen.Spielstand_Menü_Enum =>
            AktuellerText := Menuetexte.Spielstandmenü (WelcheZeileExtern);
      end case;
            
      return To_Wide_Wide_String (Source => AktuellerText);
      
   end MenüstringsSetzen;

end MenuestringsSetzenGrafik;
