with KartenDatentypen;

package KIEAchsenbewertung is
   pragma Elaborate_Body;

   function EAchseBewerten
     (ZielebeneExtern : in KartenDatentypen.EbeneVorhanden;
      AktuelleEbeneExtern : in KartenDatentypen.EbeneVorhanden;
      NeueEbeneExtern : in KartenDatentypen.EbeneVorhanden)
      return KartenDatentypen.KartenfeldNatural;

private
   use type KartenDatentypen.Ebene;
   
   type EbenenumrechnungArray is array (KartenDatentypen.EbeneVorhanden'Range) of KartenDatentypen.KartenfeldPositiv;
   Ebenenumrechnung : constant EbenenumrechnungArray := (
                                                         -2 => 1,
                                                         -1 => 2,
                                                         0 => 3,
                                                         1 => 4,
                                                         2 => 5
                                                        );
   
   type FelderArray is array (1 .. 3) of KartenDatentypen.KartenfeldNatural;
   Felder : FelderArray;

   AnzahlFelder : KartenDatentypen.KartenfeldNatural;

   WelcheFelderanzahl : Natural;
   
   
   
   function StandardübergangOben
     (ZielebeneExtern : in KartenDatentypen.EbeneVorhanden;
      AktuelleEbeneExtern : in KartenDatentypen.EbeneVorhanden;
      NeueEbeneExtern : in KartenDatentypen.EbeneVorhanden)
      return KartenDatentypen.KartenfeldNatural;
   
   function StandardübergangUnten
     (ZielebeneExtern : in KartenDatentypen.EbeneVorhanden;
      AktuelleEbeneExtern : in KartenDatentypen.EbeneVorhanden;
      NeueEbeneExtern : in KartenDatentypen.EbeneVorhanden)
      return KartenDatentypen.KartenfeldNatural;

end KIEAchsenbewertung;
