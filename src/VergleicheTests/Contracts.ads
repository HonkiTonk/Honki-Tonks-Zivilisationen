with KartenRecords;
with KartenDatentypen;

with LeseWeltkarteneinstellungen;

package Contracts is
   pragma Elaborate_Body;
   use type KartenDatentypen.EbeneBasis;
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;

   function Koordinatenprüfung
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.Ebene <= LeseWeltkarteneinstellungen.EbeneEnde
               and
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function VorhandeneKoordinatenprüfung
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.Ebene in LeseWeltkarteneinstellungen.EbeneAnfang .. LeseWeltkarteneinstellungen.EbeneEnde
               and
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

end Contracts;
