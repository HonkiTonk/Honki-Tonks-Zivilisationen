private with TonDatentypen;

package Sound is
   pragma Elaborate_Body;

   procedure Sound;

private

   type WiedergegebeneSoundsArray is array (TonDatentypen.Sound_Enum'Range) of Boolean;
   WiedergegebeneSounds : WiedergegebeneSoundsArray := (others => False);

end Sound;
