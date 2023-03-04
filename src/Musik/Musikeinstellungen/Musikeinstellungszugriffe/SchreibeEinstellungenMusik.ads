with TonRecords;
with TonKonstanten;

package SchreibeEinstellungenMusik is
   pragma Preelaborate;

   procedure Lautstärke
     (LautstärkeExtern : in Float)
     with
       Pre => (
                 LautstärkeExtern in TonKonstanten.MinimaleLautstärke .. TonKonstanten.MaximaleLautstärke
              );
   
   procedure GanzerEintrag
     (EintrageExtern : in TonRecords.MusikeinstellungenRecord);

end SchreibeEinstellungenMusik;
