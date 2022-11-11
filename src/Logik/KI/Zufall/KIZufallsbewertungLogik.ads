with KIDatentypen;

package KIZufallsbewertungLogik is
   pragma Elaborate_Body;

   function Bewertung
     (BewertungEinsExtern : in KIDatentypen.BauenBewertung;
      BewertungZweiExtern : in KIDatentypen.BauenBewertung)
      return KIDatentypen.BauenBewertung;

end KIZufallsbewertungLogik;
