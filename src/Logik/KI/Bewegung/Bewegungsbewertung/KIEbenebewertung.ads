with KartenDatentypen;

private with KartenKonstanten;

package KIEbenebewertung is
   pragma Elaborate_Body;

   function EbeneBewerten
     (ZielebeneExtern : in KartenDatentypen.EbeneVorhanden;
      NeueEbeneExtern : in KartenDatentypen.EbeneVorhanden)
      return KartenDatentypen.SenkrechteNatural;

private
   
   WelcheFelderanzahl : Positive;

   type FelderanzahlArray is array (1 .. 3) of KartenDatentypen.SenkrechteNatural;
   Felderanzahl : FelderanzahlArray;
   
   type EbenenumrechnungArray is array (KartenDatentypen.EbeneVorhanden'Range) of KartenDatentypen.SenkrechtePositiv;
   Ebenenumrechnung : constant EbenenumrechnungArray := (
                                                         KartenKonstanten.PlaneteninneresKonstante => 1,
                                                         KartenKonstanten.UnterflächeKonstante     => 2,
                                                         KartenKonstanten.OberflächeKonstante      => 3,
                                                         KartenKonstanten.HimmelKonstante          => 4,
                                                         KartenKonstanten.OrbitKonstante        => 5
                                                        );
   
   
   
   function StandardübergangOben
     (ZielebeneExtern : in KartenDatentypen.EbeneVorhanden;
      NeueEbeneExtern : in KartenDatentypen.EbeneVorhanden)
      return KartenDatentypen.SenkrechteNatural;
   
   function StandardübergangUnten
     (ZielebeneExtern : in KartenDatentypen.EbeneVorhanden;
      NeueEbeneExtern : in KartenDatentypen.EbeneVorhanden)
      return KartenDatentypen.SenkrechteNatural;

end KIEbenebewertung;
