pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with MenueDatentypen;
with SystemRecords;

package MenueaufteilungGrafik is

   procedure Menüaufteilung
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum;
      AktuelleAuswahlExtern : in SystemRecords.MehrfacheAuswahlRecord);

end MenueaufteilungGrafik;
