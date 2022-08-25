pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikDatentypen;

with AuswahlMenuesEinfach;
with AuswahlSteuerungsmenue;
with NachGrafiktask;

package body Auswahlaufteilungen is

   function AuswahlMenüsAufteilung
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
            
      NachGrafiktask.AktuellesMenü := WelchesMenüExtern;
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Menüs_Enum;
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Menü_Einfach_Enum'Range | MenueDatentypen.Menü_Doppelt_Enum =>
            return AuswahlMenuesEinfach.AuswahlMenüsEinfach (WelchesMenüExtern => WelchesMenüExtern);
            
         when MenueDatentypen.Menü_Steuerung_Enum'Range =>
            return AuswahlSteuerungsmenue.Auswahl;
      end case;
      
   end AuswahlMenüsAufteilung;
   
end Auswahlaufteilungen;
