with TonDatentypen;

package LeseMusiktask is
   pragma Preelaborate;

   function AktuelleMusikart
     return TonDatentypen.Musikart_Enum;

   function NeueMusikart
     return TonDatentypen.Musikart_Enum;

end LeseMusiktask;
