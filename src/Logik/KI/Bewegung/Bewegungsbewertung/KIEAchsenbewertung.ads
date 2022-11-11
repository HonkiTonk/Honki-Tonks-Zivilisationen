with KartenDatentypen; use KartenDatentypen;

with KIDatentypen;

package KIEAchsenbewertung is
   pragma Elaborate_Body;

   function EAchseBewerten
     (ZielebeneExtern : in KartenDatentypen.EbeneVorhanden;
      AktuelleEbeneExtern : in KartenDatentypen.EbeneVorhanden;
      NeueEbeneExtern : in KartenDatentypen.EbeneVorhanden)
      return KIDatentypen.Achsenbewertung;

private

   type BewertungArray is array (Boolean'Range) of KIDatentypen.Achsenbewertung;
   Bewertung : BewertungArray;
   
   type EbenenumrechnungArray is array (KartenDatentypen.EbeneVorhanden'Range) of Positive;
   Ebenenumrechnung : constant EbenenumrechnungArray := (
                                                         -2 => 1,
                                                         -1 => 2,
                                                         0 => 3,
                                                         1 => 4,
                                                         2 => 5
                                                        );

   ZwischenspeicherAktuell : Integer;
   ZwischenspeicherNeu : Integer;
   
   
   
   function StandardübergangOben
     (ZielebeneExtern : in KartenDatentypen.EbeneVorhanden;
      AktuelleEbeneExtern : in KartenDatentypen.EbeneVorhanden;
      NeueEbeneExtern : in KartenDatentypen.EbeneVorhanden)
      return KIDatentypen.Achsenbewertung;
   
   function StandardübergangUnten
     (ZielebeneExtern : in KartenDatentypen.EbeneVorhanden;
      AktuelleEbeneExtern : in KartenDatentypen.EbeneVorhanden;
      NeueEbeneExtern : in KartenDatentypen.EbeneVorhanden)
      return KIDatentypen.Achsenbewertung;

end KIEAchsenbewertung;
