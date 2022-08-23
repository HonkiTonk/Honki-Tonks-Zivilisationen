pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikDatentypen;

with AuswahlMenuesEinfachSFML;
-- with AuswahlMenueKartenformSFML;
with AuswahlMenueSteuerungSFML;
with AllgemeineViewsSFML;
with AuswahlMenueDoppeltSFML;

package body AuswahlMenuesSFML is

   procedure AuswahlMenüsAufteilung
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum;
      AktuelleAuswahlExtern : in Integer)
   is begin
      
      AllgemeineViewsSFML.ÜberschriftErmitteln (WelchesMenüExtern => WelchesMenüExtern);
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Menü_Einfach_Enum'Range =>
            AuswahlMenuesEinfachSFML.AuswahlMenüsEinfach (WelchesMenüExtern     => WelchesMenüExtern,
                                                           AktuelleAuswahlExtern => AktuelleAuswahlExtern);
            
         when MenueDatentypen.Menü_Doppelt_Enum =>
            AuswahlMenueDoppeltSFML.AuswahlMenüDoppelt (WelchesMenüExtern     => WelchesMenüExtern,
                                                         AktuelleAuswahlExtern => AktuelleAuswahlExtern);
            
         when MenueDatentypen.Steuerung_Menü_Enum =>
            AuswahlMenueSteuerungSFML.AuswahlMenüSteuerung;
      end case;
      
      AllgemeineViewsSFML.Versionsnummer (HintergrundExtern => GrafikDatentypen.Standard_Hintergrund_Enum);
      
   end AuswahlMenüsAufteilung;

end AuswahlMenuesSFML;
