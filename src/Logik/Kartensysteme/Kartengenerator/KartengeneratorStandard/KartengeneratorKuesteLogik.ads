private with SystemDatentypenHTSEB;

private with KommazahltestsHTSEB;

private with KartenDatentypen;
private with KartenRecords;

private with LeseWeltkarteneinstellungen;

package KartengeneratorKuesteLogik is
   pragma Elaborate_Body;

   procedure GenerierungKüstenSeeGewässer;

private
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;
   
   KartenWert : KartenRecords.KartenfeldNaturalRecord;

   LadezeitBasis : Float;
   Ladezeit : Float;
   
   procedure GewässerFestlegen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );



   function LadezeitTesten is new KommazahltestsHTSEB.StrichrechnungNatural (Kommazahl => SystemDatentypenHTSEB.LadezeitBasis);

end KartengeneratorKuesteLogik;
