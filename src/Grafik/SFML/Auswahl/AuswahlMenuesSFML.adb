pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with AuswahlMenuesOhneUeberschriftSFML;

package body AuswahlMenuesSFML is

   procedure AuswahlMenüsAufteilung
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Vorhanden_Enum)
   is begin
      
      case
        WelchesMenüExtern
      is
         when SystemDatentypen.Menü_Ohne_Überschrift_Enum =>
            AuswahlMenuesOhneUeberschriftSFML.AuswahlMenüsOhneÜberschrift (WelchesMenüExtern => WelchesMenüExtern);
            
         when SystemDatentypen.Menü_Mit_Überschrift_Enum =>
            null;
            
         when SystemDatentypen.Menü_Zusatztext_Enum =>
            null;
            
         when SystemDatentypen.Menü_Komplex_Enum =>
            null;
      end case;
      
   end AuswahlMenüsAufteilung;

end AuswahlMenuesSFML;
