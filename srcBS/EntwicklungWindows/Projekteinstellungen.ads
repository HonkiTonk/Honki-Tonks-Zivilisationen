with SystemRecords;

package Projekteinstellungen is
   pragma Preelaborate;

   Debug : SystemRecords.DebugRecord := (
                                         VolleInformation => True,
                                         FehlerWarnung    => True,
                                         LinuxWindows     => False,
                                         NormalerText     => True
                                        );

end Projekteinstellungen;
