pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.View;

with GrafikDatentypen;

with AuswahlMenuesEinfachSFML;
with AuswahlMenueKartenformSFML;
with AuswahlMenueSteuerungSFML;
with Fehler;
with ViewsEinstellenSFML;
with HintergrundSFML;
with ViewsSFML;

package body AuswahlMenuesSFML is

   procedure AuswahlMenüsAufteilung
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Enum)
   is begin
                  
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern    => ViewsSFML.MenüviewAccess,
                                          GrößeExtern   => Viewfläche);
      HintergrundSFML.StandardHintergrund (HintergrundExtern => GrafikDatentypen.Standard_Hintergrund_Enum);
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Leer_Menü_Enum =>
            Fehler.GrafikFehler (FehlermeldungExtern => "AuswahlMenuesSFML.AuswahlMenüsAufteilung - Kein Menü ausgewählt.");
            
         when MenueDatentypen.Menü_Einfach_Enum =>
            Viewfläche := AuswahlMenuesEinfachSFML.AuswahlMenüsEinfach (WelchesMenüExtern => WelchesMenüExtern);
            
         when MenueDatentypen.Kartenform_Menü_Enum =>
            AuswahlMenueKartenformSFML.AuswahlMenüKartenform;
            
         when MenueDatentypen.Steuerung_Menü_Enum =>
            AuswahlMenueSteuerungSFML.AuswahlMenüSteuerung;
      end case;
      
      Sf.Graphics.View.setViewport (view     => ViewsSFML.MenüviewAccess,
                                    viewport => (0.00, 0.00, 1.00, 1.00));
      
   end AuswahlMenüsAufteilung;

end AuswahlMenuesSFML;
