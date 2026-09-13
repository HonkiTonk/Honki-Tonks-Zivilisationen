with KartenDatentypen;
with KartenKonstanten;
with KartenRecords;
with SystemDatentypen;

with LeseWeltkarteneinstellungen;

package KartenkoordinatenberechnungssystemLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;
   use type KartenDatentypen.EbeneBasis;

   function Koordinatenberechnung
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      ÄnderungExtern : in KartenRecords.KartenfeldRecord;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenRecords.KartenfeldNaturalRecord
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 KoordinatenExtern.Ebene in LeseWeltkarteneinstellungen.EbeneAnfang .. LeseWeltkarteneinstellungen.EbeneEnde
              ),
           
       Post => (
                (if
                      Koordinatenberechnung'Result.Senkrechte = KartenKonstanten.LeerSenkrechte
                        then
                  (Koordinatenberechnung'Result.Waagerechte = KartenKonstanten.LeerWaagerechte
                   and
                     Koordinatenberechnung'Result.Ebene = KartenKonstanten.LeerEbene)
               )
                and
                  (if
                         Koordinatenberechnung'Result.Waagerechte = KartenKonstanten.LeerWaagerechte
                           then
                     (Koordinatenberechnung'Result.Senkrechte = KartenKonstanten.LeerSenkrechte
                      and
                        Koordinatenberechnung'Result.Ebene = KartenKonstanten.LeerEbene)
                  )
                and
                  (if
                         Koordinatenberechnung'Result.Ebene = KartenKonstanten.LeerEbene
                           then
                     (Koordinatenberechnung'Result.Senkrechte = KartenKonstanten.LeerSenkrechte
                      and
                        Koordinatenberechnung'Result.Waagerechte = KartenKonstanten.LeerWaagerechte)
                  )
                and
                  Koordinatenberechnung'Result.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
                and
                  Koordinatenberechnung'Result.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
                and
                -- Entweder so lösen oder auch mit <= EbeneEnde, wobei die meisten Dinge gar keine -3 bei der Koordinatenebene erlauben sollten. äöü
                  (Koordinatenberechnung'Result.Ebene in LeseWeltkarteneinstellungen.EbeneAnfang .. LeseWeltkarteneinstellungen.EbeneEnde
                   or
                     Koordinatenberechnung'Result.Ebene = KartenKonstanten.LeerEbene)
               );
   
   function KoordinatenberechnungEbenenfest
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      ÄnderungExtern : in KartenRecords.KartenfeldumgebungRecord;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenRecords.KartenfeldNaturalRecord
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 KoordinatenExtern.Ebene in LeseWeltkarteneinstellungen.EbeneAnfang .. LeseWeltkarteneinstellungen.EbeneEnde
              ),
           
       Post => (
                (if
                      KoordinatenberechnungEbenenfest'Result.Senkrechte = KartenKonstanten.LeerSenkrechte
                        then
                  (KoordinatenberechnungEbenenfest'Result.Waagerechte = KartenKonstanten.LeerWaagerechte
                   and
                     KoordinatenberechnungEbenenfest'Result.Ebene = KartenKonstanten.LeerEbene)
               )
                and
                  (if
                         KoordinatenberechnungEbenenfest'Result.Waagerechte = KartenKonstanten.LeerWaagerechte
                           then
                     (KoordinatenberechnungEbenenfest'Result.Senkrechte = KartenKonstanten.LeerSenkrechte
                      and
                        KoordinatenberechnungEbenenfest'Result.Ebene = KartenKonstanten.LeerEbene)
                  )
                and
                  (if
                         KoordinatenberechnungEbenenfest'Result.Ebene = KartenKonstanten.LeerEbene
                           then
                     (KoordinatenberechnungEbenenfest'Result.Senkrechte = KartenKonstanten.LeerSenkrechte
                      and
                        KoordinatenberechnungEbenenfest'Result.Waagerechte = KartenKonstanten.LeerWaagerechte)
                  )
                and
                  KoordinatenberechnungEbenenfest'Result.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
                and
                  KoordinatenberechnungEbenenfest'Result.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
                and
                  (KoordinatenberechnungEbenenfest'Result.Ebene in LeseWeltkarteneinstellungen.EbeneAnfang .. LeseWeltkarteneinstellungen.EbeneEnde
                   or
                     KoordinatenberechnungEbenenfest'Result.Ebene = KartenKonstanten.LeerEbene)
               );
   
   function KoordinatenberechnungUmgebungfest
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      ÄnderungExtern : in KartenDatentypen.EbeneBasis;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenRecords.KartenfeldNaturalRecord
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 KoordinatenExtern.Ebene in LeseWeltkarteneinstellungen.EbeneAnfang .. LeseWeltkarteneinstellungen.EbeneEnde
              ),
           
       Post => (
                (if
                      KoordinatenberechnungUmgebungfest'Result.Senkrechte = KartenKonstanten.LeerSenkrechte
                        then
                  (KoordinatenberechnungUmgebungfest'Result.Waagerechte = KartenKonstanten.LeerWaagerechte
                   and
                     KoordinatenberechnungUmgebungfest'Result.Ebene = KartenKonstanten.LeerEbene)
               )
                and
                  (if
                         KoordinatenberechnungUmgebungfest'Result.Waagerechte = KartenKonstanten.LeerWaagerechte
                           then
                     (KoordinatenberechnungUmgebungfest'Result.Senkrechte = KartenKonstanten.LeerSenkrechte
                      and
                        KoordinatenberechnungUmgebungfest'Result.Ebene = KartenKonstanten.LeerEbene)
                  )
                and
                  (if
                         KoordinatenberechnungUmgebungfest'Result.Ebene = KartenKonstanten.LeerEbene
                           then
                     (KoordinatenberechnungUmgebungfest'Result.Senkrechte = KartenKonstanten.LeerSenkrechte
                      and
                        KoordinatenberechnungUmgebungfest'Result.Waagerechte = KartenKonstanten.LeerWaagerechte)
                  )
                and
                  KoordinatenberechnungUmgebungfest'Result.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
                and
                  KoordinatenberechnungUmgebungfest'Result.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
                and
                  (KoordinatenberechnungUmgebungfest'Result.Ebene in LeseWeltkarteneinstellungen.EbeneAnfang .. LeseWeltkarteneinstellungen.EbeneEnde
                   or
                     KoordinatenberechnungUmgebungfest'Result.Ebene = KartenKonstanten.LeerEbene)
               );
     
private
   
   type NeueKoordinateArray is array (SystemDatentypen.Task_Enum'Range) of KartenRecords.KartenfeldNaturalRecord;
   NeueKoordinate : NeueKoordinateArray;
   
end KartenkoordinatenberechnungssystemLogik;
