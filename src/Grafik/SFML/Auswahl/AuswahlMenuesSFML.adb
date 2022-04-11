pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with AuswahlMenuesOhneMitUeberschriftSFML;
with AuswahlMenuesMitZusatztextSFML;
with AuswahlMenuesKomplexSFML;

package body AuswahlMenuesSFML is

   procedure AuswahlMenüsAufteilung
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Vorhanden_Enum)
   is begin
      
      case
        WelchesMenüExtern
      is
         when SystemDatentypen.Menü_Ohne_Überschrift_Enum =>
            AuswahlMenuesOhneMitUeberschriftSFML.AuswahlMenüsMitOhneÜberschrift (WelchesMenüExtern => WelchesMenüExtern);
            
         when SystemDatentypen.Menü_Mit_Überschrift_Enum =>
            AuswahlMenuesOhneMitUeberschriftSFML.AuswahlMenüsMitOhneÜberschrift (WelchesMenüExtern => WelchesMenüExtern);
            
         when SystemDatentypen.Menü_Zusatztext_Enum =>
            AuswahlMenuesMitZusatztextSFML.AuswahlMenüsMitZusatztext;
            
         when SystemDatentypen.Menü_Komplex_Enum =>
            AuswahlMenuesKomplexSFML.AuswahlMenüsKomplexSFML;
      end case;
      
   end AuswahlMenüsAufteilung;

end AuswahlMenuesSFML;
