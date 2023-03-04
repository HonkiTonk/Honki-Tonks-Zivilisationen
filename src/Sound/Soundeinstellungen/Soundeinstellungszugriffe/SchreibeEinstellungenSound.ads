with TonKonstanten;
with TonRecords;

package SchreibeEinstellungenSound is
   pragma Preelaborate;

   procedure Lautstärke
     (LautstärkeExtern : in Float)
     with
       Pre => (
                 LautstärkeExtern in TonKonstanten.MinimaleLautstärke .. TonKonstanten.MaximaleLautstärke
              );
   
   procedure GanzerEintrag
     (EintragExtern : in TonRecords.SoundeinstellungenRecord);

end SchreibeEinstellungenSound;
