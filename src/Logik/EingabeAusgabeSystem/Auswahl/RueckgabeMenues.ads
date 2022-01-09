pragma SPARK_Mode (On);

with SystemDatentypen;

package RueckgabeMenues is
   
   function RückgabeMenüs
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive;
      WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum;
   
private

   function Hauptmenü
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum;

   function Spielmenü
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum;

   function Optionsmenü
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum;

   function KartengrößeAuswählen
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum;

   function KartenartAuswählen
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum;

   function KartenformAuswählen
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum;

   function KartentemperaturAuswählen
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum;

   function KartenRessourcenAuswählen
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum;

   function SchwierigkeitsgradAuswählen
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum;

   function RasseAuswählen
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum;
   
   function GrafikMenü
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum;
            
   function SoundMenü
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum;
            
   function SteuerungMenü
     (EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum;
   
   function SonstigesMenü
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum;
   
   function ZurückHauptmenüEnde
     (EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum;

end RueckgabeMenues;
