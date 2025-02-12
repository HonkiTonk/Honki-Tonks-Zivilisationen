private with AllgemeineBerechnungenHTSEB;

private with KartenDatentypen;
private with KartenRecords;

private with LeseWeltkarteneinstellungen;

package KartengeneratorKuesteLogik is
   pragma Elaborate_Body;

   procedure GenerierungKüstenSeeGewässer;

private
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;
   
   Kartenzeitwert : KartenDatentypen.SenkrechtePositiv;
   
   KartenWert : KartenRecords.KartenfeldNaturalRecord;
   
   procedure GewässerFestlegen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   
   
   function Basiszeitwert is new AllgemeineBerechnungenHTSEB.Basiszeitwert (GanzeZahl => KartenDatentypen.SenkrechtePositiv);

end KartengeneratorKuesteLogik;
