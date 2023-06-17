with TonKonstanten;

package LeseEinstellungenTon is
   pragma Preelaborate;

   function Soundlautstärke
     return Float
     with
       Post => (
                  Soundlautstärke'Result in TonKonstanten.MinimaleLautstärke .. TonKonstanten.MaximaleLautstärke
               );
   pragma Inline (Soundlautstärke);
   
   function Musiklautstärke
     return Float
     with
       Post => (
                  Musiklautstärke'Result in TonKonstanten.MinimaleLautstärke .. TonKonstanten.MaximaleLautstärke
               );
   pragma Inline (Musiklautstärke);

end LeseEinstellungenTon;
