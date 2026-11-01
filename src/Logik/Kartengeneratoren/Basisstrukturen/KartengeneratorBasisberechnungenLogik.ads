with KartenDatentypen;

private with KartenartDatentypen;
private with KartenRecords;

with LeseWeltkarteneinstellungen;

package KartengeneratorBasisberechnungenLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;
   
   function StartSenkrechte
     (SenkrechteExtern : in KartenDatentypen.SenkrechtePositiv;
      AnfangExtern : in KartenDatentypen.SenkrechtePositiv;
      EndeExtern : in KartenDatentypen.SenkrechtePositiv)
      return KartenDatentypen.SenkrechtePositiv
     with
       Pre => (
                 SenkrechteExtern <= LeseWeltkarteneinstellungen.Senkrechte
              );
     
   function StartWaagerechte
     (WaagerechteExtern : in KartenDatentypen.WaagerechtePositiv;
      AnfangExtern : in KartenDatentypen.WaagerechtePositiv;
      EndeExtern : in KartenDatentypen.WaagerechtePositiv)
      return KartenDatentypen.WaagerechtePositiv
     with
       Pre => (
                 WaagerechteExtern <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
private
   
   ÜbergangNorden : KartenartDatentypen.Kartenform_Senkrechte_Einstellbar_Enum;
   ÜbergangSüden : KartenartDatentypen.Kartenform_Senkrechte_Einstellbar_Enum;
   
   ÜbergangWesten : KartenartDatentypen.Kartenform_Waagerechte_Einstellbar_Enum;
   ÜbergangOsten : KartenartDatentypen.Kartenform_Waagerechte_Einstellbar_Enum;
   
   Schleifenbereich : KartenRecords.LandgrößenNaturalRecord;

end KartengeneratorBasisberechnungenLogik;
