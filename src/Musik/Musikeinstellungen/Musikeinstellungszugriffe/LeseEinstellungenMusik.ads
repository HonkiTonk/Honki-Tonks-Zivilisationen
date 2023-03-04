with TonRecords;
with TonKonstanten;

package LeseEinstellungenMusik is
   pragma Preelaborate;

   function Lautstärke
     return Float
     with
       Post => (
                  Lautstärke'Result in TonKonstanten.MinimaleLautstärke .. TonKonstanten.MaximaleLautstärke
               );
   
   function GanzerEintrag
     return TonRecords.MusikeinstellungenRecord;

end LeseEinstellungenMusik;
