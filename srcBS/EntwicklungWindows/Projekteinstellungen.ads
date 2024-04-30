with SystemRecords;
with SystemDatentypen;

package Projekteinstellungen is
   pragma Preelaborate;

   Einstellungen : constant SystemRecords.DebugRecord := (
                                         VolleInformation => True,
                                         FehlerWarnung    => True,
                                         Betriebssystem     => SystemDatentypen.Windows_Enum
                                        );

end Projekteinstellungen;
