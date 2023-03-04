with TonRecords;

package EinstellungenSound is
   pragma Preelaborate;

   Soundeinstellungen : TonRecords.SoundeinstellungenRecord;

   procedure StandardeinstellungenLaden;

private

   SoundeinstellungenStandard : constant TonRecords.SoundeinstellungenRecord := (
                                                                                 Lautstärke => 50.00
                                                                                );

end EinstellungenSound;
