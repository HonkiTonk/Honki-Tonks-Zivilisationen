with TonKonstanten;
with TonRecords;

package LeseEinstellungenSound is
   pragma Preelaborate;

   function Lautstärke
     return Float
     with
       Post => (
                  Lautstärke'Result in TonKonstanten.MinimaleLautstärke .. TonKonstanten.MaximaleLautstärke
               );
   
   -- Für die ganzen Funktionen/Prozeduren die einen ganzen Eintrag bearbeiten auch mal Contracts einbauen? äöü
   function GanzerEintrag
     return TonRecords.SoundeinstellungenRecord;

end LeseEinstellungenSound;
