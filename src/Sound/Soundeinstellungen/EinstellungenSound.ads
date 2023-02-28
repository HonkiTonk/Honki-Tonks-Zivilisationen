with TonRecords;

package EinstellungenSound is
   pragma Preelaborate;

   Soundeinstellungen : TonRecords.SoundeinstellungenRecord;

   Lautstärke : Float := 50.00;

   procedure StandardeinstellungenLaden;

private

   Standardlautstärke : constant Float := 50.00;

   SoundeinstellungenStandard : constant TonRecords.SoundeinstellungenRecord := (
                                                                                 Lautstärke => 50.00
                                                                                );

end EinstellungenSound;
