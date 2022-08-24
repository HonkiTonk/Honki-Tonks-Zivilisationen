pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikDatentypen;

with AuswahlMenuesEinfachSFML;
with AuswahlMenueSteuerungSFML;
with AllgemeineViewsSFML;
with AuswahlMenueDoppeltSFML;

-- Hier bekommt man bestimmt auch noch irgendwie die Auswahl für die Bau- und Forschungsmenü rein. äöü
-- Entsprechende Umwandlungen in den beiden Menüs auch noch anpassen und die Mehrfachauswahl so aus dem NachGrafiktask rausbekommen. äöü
package body AuswahlMenuesSFML is

   procedure AuswahlMenüsAufteilung
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum;
      AktuelleAuswahlExtern : in SystemRecords.MehrfacheAuswahlRecord)
   is begin
      
      AllgemeineViewsSFML.ÜberschriftErmitteln (WelchesMenüExtern => WelchesMenüExtern);
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Menü_Einfach_Enum'Range =>
            AuswahlMenuesEinfachSFML.AuswahlMenüsEinfach (WelchesMenüExtern     => WelchesMenüExtern,
                                                           AktuelleAuswahlExtern => AktuelleAuswahlExtern.AuswahlEins);
            
         when MenueDatentypen.Menü_Doppelt_Enum =>
            AuswahlMenueDoppeltSFML.AuswahlMenüDoppelt (WelchesMenüExtern     => WelchesMenüExtern,
                                                         AktuelleAuswahlExtern => AktuelleAuswahlExtern.AuswahlEins);
            
         when MenueDatentypen.Steuerung_Menü_Enum =>
            AuswahlMenueSteuerungSFML.AuswahlMenüSteuerung (AuswahlExtern => AktuelleAuswahlExtern);
      end case;
      
      AllgemeineViewsSFML.Versionsnummer (HintergrundExtern => GrafikDatentypen.Standard_Hintergrund_Enum);
      
   end AuswahlMenüsAufteilung;

end AuswahlMenuesSFML;
