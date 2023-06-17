with TonKonstanten;
with TonRecords;

package SchreibeEinstellungenTon is
   pragma Preelaborate;

   procedure Soundlautstärke
     (LautstärkeExtern : in Float)
     with
       Pre => (
                 LautstärkeExtern in TonKonstanten.MinimaleLautstärke .. TonKonstanten.MaximaleLautstärke
              );
   pragma Inline (Soundlautstärke);
   
   procedure Musiklautstärke
     (LautstärkeExtern : in Float)
     with
       Pre => (
                 LautstärkeExtern in TonKonstanten.MinimaleLautstärke .. TonKonstanten.MaximaleLautstärke
              );
   pragma Inline (Musiklautstärke);
   
   procedure GesamteToneinstellungen
     (EinstellungenExtern : in TonRecords.ToneinstellungenRecord);
   pragma Inline (GesamteToneinstellungen);

end SchreibeEinstellungenTon;
