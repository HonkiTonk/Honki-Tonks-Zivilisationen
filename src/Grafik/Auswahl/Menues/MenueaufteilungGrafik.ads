with MenueDatentypen;
with SystemRecords;

package MenueaufteilungGrafik is
   pragma Elaborate_Body;

   procedure Menüaufteilung
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum;
      AktuelleAuswahlExtern : in SystemRecords.MehrfachauswahlRecord);

end MenueaufteilungGrafik;
