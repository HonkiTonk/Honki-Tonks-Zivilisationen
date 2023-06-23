with KartenDatentypen;

private with KartenKonstanten;

package KIEAchsenbewertung is
   pragma Elaborate_Body;

   function EAchseBewerten
     (ZielebeneExtern : in KartenDatentypen.EbeneVorhanden;
      NeueEbeneExtern : in KartenDatentypen.EbeneVorhanden)
      return KartenDatentypen.KartenfeldNatural;

private
   
   WelcheFelderanzahl : Positive;

   type FelderanzahlArray is array (1 .. 3) of KartenDatentypen.KartenfeldNatural;
   Felderanzahl : FelderanzahlArray;
   
   type EbenenumrechnungArray is array (KartenDatentypen.EbeneVorhanden'Range) of KartenDatentypen.KartenfeldPositiv;
   Ebenenumrechnung : constant EbenenumrechnungArray := (
                                                         KartenKonstanten.PlaneteninneresKonstante => 1,
                                                         KartenKonstanten.UnterflächeKonstante     => 2,
                                                         KartenKonstanten.OberflächeKonstante      => 3,
                                                         KartenKonstanten.HimmelKonstante          => 4,
                                                         KartenKonstanten.WeltraumKonstante        => 5
                                                        );
   
   
   
   function StandardübergangOben
     (ZielebeneExtern : in KartenDatentypen.EbeneVorhanden;
      NeueEbeneExtern : in KartenDatentypen.EbeneVorhanden)
      return KartenDatentypen.KartenfeldNatural;
   
   function StandardübergangUnten
     (ZielebeneExtern : in KartenDatentypen.EbeneVorhanden;
      NeueEbeneExtern : in KartenDatentypen.EbeneVorhanden)
      return KartenDatentypen.KartenfeldNatural;

end KIEAchsenbewertung;
