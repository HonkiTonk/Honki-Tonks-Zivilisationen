with SystemRecords;

package Projekteinstellungen is
   pragma Preelaborate;

   Debug : SystemRecords.DebugRecord := (
                                         VolleInformation => False,
                                         FehlerWarnung    => False,
                                         LinuxWindows     => False,
                                         NormalerText     => True
                                        );

end Projekteinstellungen;
