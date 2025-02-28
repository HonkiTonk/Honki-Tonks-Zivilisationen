with TonDatentypen;

package TonRecords is
   pragma Pure;
   
   type ToneinstellungenRecord is record
      
      Soundlautstärke : Float;
      Musiklautstärke : Float;
      
   end record;
   
   
   
   type MusikartRecord is record
      
      AktuelleMusikart : TonDatentypen.Musikart_Enum;
      NeueMusikart : TonDatentypen.Musikart_Enum;
      
   end record;

end TonRecords;
