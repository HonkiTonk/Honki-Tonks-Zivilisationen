with KartenDatentypen;

with KIDatentypen;

package KIEAchsenbewertung is
   pragma Elaborate_Body;

   function EAchseBewerten
     (ZielebeneExtern : in KartenDatentypen.EbeneVorhanden;
      AktuelleEbeneExtern : in KartenDatentypen.EbeneVorhanden;
      NeueEbeneExtern : in KartenDatentypen.EbeneVorhanden)
      return KIDatentypen.Achsenbewertung;
   
private
   
   EntfernungZiel : Natural;
   EntfernungNeu : Natural;
   EntfernungAlt : Natural;

end KIEAchsenbewertung;
