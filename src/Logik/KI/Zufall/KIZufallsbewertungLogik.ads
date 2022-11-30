with KIDatentypen;

package KIZufallsbewertungLogik is
   pragma Preelaborate;

   function Bewertung
     (BewertungEinsExtern : in KIDatentypen.BauenBewertung;
      BewertungZweiExtern : in KIDatentypen.BauenBewertung)
      return KIDatentypen.BauenBewertung;

end KIZufallsbewertungLogik;
