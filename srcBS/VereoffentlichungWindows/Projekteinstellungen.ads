with SystemRecords;
with SystemDatentypen;

package Projekteinstellungen is
   pragma Preelaborate;

   Einstellungen : constant SystemRecords.DebugRecord := (
                                         VolleInformation => False,
                                         FehlerWarnung    => False,
                                         Betriebssystem     => SystemDatentypen.Windows_Enum
                                        );

end Projekteinstellungen;
