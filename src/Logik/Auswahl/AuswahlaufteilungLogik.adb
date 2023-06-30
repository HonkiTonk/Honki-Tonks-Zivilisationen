with GrafikDatentypen;

with MenueauswahlLogik;
with SteuerungsauswahlLogik;
with Grafiktask;

package body AuswahlaufteilungLogik is

   function AuswahlMenüsAufteilung
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
            
      Grafiktask.Grafik.AktuellesMenü := WelchesMenüExtern;
      Grafiktask.Grafik.AktuelleDarstellung := GrafikDatentypen.Menüs_Enum;
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Menü_Einfach_Enum'Range | MenueDatentypen.Menü_Doppelt_Enum =>
            return MenueauswahlLogik.AuswahlMenüsEinfach (WelchesMenüExtern => WelchesMenüExtern);
            
         when MenueDatentypen.Menü_Steuerung_Enum'Range =>
            return SteuerungsauswahlLogik.Auswahl;
            
            -- Das passt nicht in die Menüs wegen diversen Spezialeigenschaften, ähnlich wie die Sprachauswahl.
         when MenueDatentypen.Spielstand_Menü_Enum =>
            return RueckgabeDatentypen.Start_Weiter_Enum;
      end case;
      
   end AuswahlMenüsAufteilung;
   
end AuswahlaufteilungLogik;
