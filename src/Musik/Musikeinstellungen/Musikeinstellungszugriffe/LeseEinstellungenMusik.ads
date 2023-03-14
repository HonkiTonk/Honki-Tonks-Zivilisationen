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
   pragma Inline (Lautstärke);
   
   function GanzerEintrag
     return TonRecords.MusikeinstellungenRecord;
   pragma Inline (GanzerEintrag);

end LeseEinstellungenMusik;
